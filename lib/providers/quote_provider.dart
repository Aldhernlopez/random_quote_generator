import 'package:flutter/material.dart';
import 'package:random_quotes_generator/api_models/quote_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class QuoteProvider with ChangeNotifier{
  Quote _quote = Quote(author: '', quote: '');
  bool _isLoading = false;

  Quote get quote => _quote;
  bool get isLoading => _isLoading;

  Future<void> fetchQuote() async{

    _isLoading = true;
    notifyListeners();

    const url = "https://stoic.tekloon.net/stoic-quote";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      _quote = Quote.fromJson(responseData);
      notifyListeners();
    }
    else {
      throw Exception('Unable to load a Quote!');
    }

    _isLoading = false;
    notifyListeners();
  }
}