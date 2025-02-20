import 'package:breakingbad/datamodel/quote_model.dart';
import 'package:breakingbad/services/quote_api_bb.dart';

class QuoteRepository {
  final QuoteAPIBreakingBad quoteAPIBreakingBad;

  QuoteRepository(this.quoteAPIBreakingBad);

  Future<List<QuoteModel>> getQuotes() async {
    return await quoteAPIBreakingBad.fetchQuotes();
  }
}