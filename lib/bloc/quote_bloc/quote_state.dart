import 'package:equatable/equatable.dart';
import 'package:breakingbad/datamodel/quote_model.dart';

abstract class QuoteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuoteInitialState extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuoteLoadingState extends QuoteState {}

class QuoteLoadedState extends QuoteState {
  final List<QuoteModel> quotes;

  QuoteLoadedState(this.quotes);

  @override
  List<Object?> get props => [quotes];
}

class QuoteErrorState extends QuoteState {
  final String message;

  QuoteErrorState(this.message);
}
