import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakingbad/bloc/quote_bloc/quote_bloc.dart';
import 'package:breakingbad/bloc/quote_bloc/quote_event.dart';
import 'package:breakingbad/bloc/quote_bloc/quote_state.dart';
import '../datamodel/quote_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<QuoteBloc>().add(QuoteLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: [
              BlocBuilder<QuoteBloc, QuoteState>(
                builder: (context, state) {
                  if (state is QuoteLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is QuoteLoadedState) {
                    List<QuoteModel> quotes = state.quotes;
                    if (quotes.isEmpty) {
                      return const Center(child: Text("Nessun film disponibile"));
                    }
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true, // Necessario per ListView all'interno di SingleChildScrollView
                          physics: const NeverScrollableScrollPhysics(), // Evita conflitti di scroll
                          itemCount: quotes.length,
                          itemBuilder: (context, index) {
                            var quote = quotes[index];
                            return GestureDetector(
                              onTap: () => {},
                              child: Card(
                                color: Colors.white.withOpacity(0.3),
                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              quote.quote,
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 6),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else if (state is QuoteErrorState) {
                    return Center(
                      child: Text(
                        "Errore: ${state.message}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
