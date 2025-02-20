import 'dart:convert';
import 'package:breakingbad/datamodel/quote_model.dart';
import 'package:http/http.dart' as http;

class QuoteAPIBreakingBad {
  final String baseurl = 'https://api.breakingbadquotes.xyz/v1/quotes/5';

  Future<List<QuoteModel>> fetchQuotes() async {
    try {
      var url = Uri.parse(baseurl);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        List<QuoteModel> quotes = (data as List)
            .map((quoteJson) => QuoteModel.fromJson(quoteJson))
            .toList();

        return quotes;
      } else {
        print("Errore nella richiesta: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print('Errore: $e');
      return [];
    }
  }
}
