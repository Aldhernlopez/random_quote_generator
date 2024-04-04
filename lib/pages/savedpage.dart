import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:random_quotes_generator/db_models/quote_db.dart';
import 'package:random_quotes_generator/pages/widgets/custom_drawer.dart';
import 'package:random_quotes_generator/providers/isar_provider.dart';

class SavedQuotesPage extends StatefulWidget {
  const SavedQuotesPage({super.key});

  @override
  State<SavedQuotesPage> createState() => _SavedQuotesPageState();
}

class _SavedQuotesPageState extends State<SavedQuotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Quotes",
          style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 25
        ),
        child: SafeArea(
          child: Consumer<IsarProvider>(
            builder: (context, dbProvider, _){
              return FutureBuilder<List<QuoteDB>>(
                  future: dbProvider.fetchQuotes(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else if(snapshot.hasError){
                      return Center(
                          child: Text("Unexpected Error: ${snapshot.error}"),
                      );
                    }
                    else {
                      final favQuotes = snapshot.data ?? [];
                      return ListView.separated(
                          itemBuilder: (context, index){
                            final quote = favQuotes[index];
                            return ListTile(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              tileColor: Colors.grey.withOpacity(0.075),
                              title: Text(quote.quote,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(),
                              ),
                              subtitle: Text(quote.author,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: Colors.white70
                                ),
                              ),
                              trailing: IconButton(
                                  onPressed: () async {
                                    await _deleteFavQuote(context, dbProvider, quote);
                                  },
                                  icon: const Icon(Icons.delete,
                                    color: Colors.white,
                                  ),
                              ),
                              onTap: (){
                                _showQuoteDetails(context, quote.author, quote.quote);
                              },
                            );
                          },
                          separatorBuilder: (context, index){
                            return const SizedBox(height: 20);
                          },
                          itemCount: favQuotes.length,
                      );
                    }
                  },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showQuoteDetails(BuildContext context, String author, String quote) async{
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(author,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                  fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ),
            content: Text(quote,
              style: GoogleFonts.poppins(
                  fontSize: 16,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  side: const MaterialStatePropertyAll<BorderSide>(BorderSide(color: Colors.white)),
                  shape: MaterialStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  backgroundColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
                ),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Close",
                    style: GoogleFonts.merriweather(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
              )
            ],
          );
        },
    );
  }

  Future<void> _deleteFavQuote(BuildContext context, IsarProvider provider, QuoteDB quote) async{
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Confirmation",
              style: GoogleFonts.merriweather(),
            ),
            content: Text("Are you sure about removing this quote from your favorite list?",
              style: GoogleFonts.poppins(
                fontSize: 16
              ),
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  side: const MaterialStatePropertyAll<BorderSide>(BorderSide(color: Colors.white)),
                  shape: MaterialStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  backgroundColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
                ),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel",
                    style: GoogleFonts.merriweather(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  side: const MaterialStatePropertyAll<BorderSide>(BorderSide(color: Colors.transparent)),
                  shape: MaterialStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red.shade700),
                  foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
                ),
                  onPressed: () {
                    provider.deleteQuote(quote);
                    Navigator.of(context).pop();
                  },
                  child: Text("Delete",
                    style: GoogleFonts.merriweather(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        }
        );
  }
}
