import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_quotes_generator/db_models/quote_db.dart';

class IsarProvider extends ChangeNotifier{
  static late Isar _isar;

  static Future<void> initializeDatabase() async{
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
        [QuoteDBSchema],
        directory: dir.path,
    );
  }

  Future<void> addFavorite(String author, String favQuote) async{
    final quote = QuoteDB()
        ..author = author
        ..quote = favQuote;
    await _isar.writeTxn(
            () => _isar.quoteDBs.put(quote),
    );
    fetchQuotes();
    notifyListeners();
  }

  Future<List<QuoteDB>> fetchQuotes() async{
    return _isar.quoteDBs.where().findAll();
  }

  Future<void> deleteQuote(QuoteDB quote) async{
    await _isar.writeTxn(() async{
      await _isar.quoteDBs.delete(quote.id);
    });
    fetchQuotes();
    notifyListeners();
  }
}