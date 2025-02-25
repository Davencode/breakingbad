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
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text("Breaking Bad Quotes", style: TextStyle(color: Colors.greenAccent)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
          if (state is QuoteLoadingState) {
            return const Center(child: CircularProgressIndicator(color: Colors.greenAccent));
          } else if (state is QuoteLoadedState) {
            List<QuoteModel> quotes = state.quotes;
            if (quotes.isEmpty) {
              return const Center(child: Text("Nessuna citazione disponibile", style: TextStyle(color: Colors.white)));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                var quote = quotes[index];
                return AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 500 + (index * 100)),
                  child: Card(
                    color: Colors.greenAccent.withOpacity(0.2),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '"${quote.quote}"',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              '- ${quote.author}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
    );
  }
}
