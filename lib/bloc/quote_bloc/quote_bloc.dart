import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:breakingbad/bloc/quote_bloc/quote_event.dart';
import 'package:breakingbad/bloc/quote_bloc/quote_state.dart';
import 'package:breakingbad/repository/quote_repository.dart';


class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {

  final QuoteRepository repository;

  QuoteBloc(this.repository) : super(QuoteInitialState()) {
    on<QuoteLoadedEvent>((event, emit) async {
        emit(QuoteLoadingState());

        try {
          final quotes = await repository.getQuotes();
          emit(QuoteLoadedState(quotes));
        }catch(e){
          emit(QuoteErrorState("Errore nel caricamento: ${e.toString()}"));
        }
    });
  }
}
