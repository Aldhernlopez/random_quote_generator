import 'package:isar/isar.dart';

part 'quote_db.g.dart';

@collection
class QuoteDB{
  Id id = Isar.autoIncrement;
  late String author;
  late String quote;
}