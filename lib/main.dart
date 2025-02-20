import 'package:breakingbad/bloc/quote_bloc/quote_bloc.dart';
import 'package:breakingbad/repository/quote_repository.dart';
import 'package:breakingbad/screens/homepage.dart';
import 'package:breakingbad/services/quote_api_bb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => QuoteBloc(QuoteRepository(QuoteAPIBreakingBad()))),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
