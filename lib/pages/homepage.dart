import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:random_quotes_generator/pages/widgets/custom_button_row.dart';
import 'package:random_quotes_generator/pages/widgets/custom_drawer.dart';
import 'package:random_quotes_generator/providers/quote_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    Provider.of<QuoteProvider>(context, listen: false).fetchQuote();
  }
  @override
  Widget build(BuildContext context) {
    late String author = '';
    late String quote = '';

    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes",
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
          child: Center(
            child: Consumer<QuoteProvider>(
                builder: (context, quoteProvider, _){
                  author = quoteProvider.quote.author;
                  quote = quoteProvider.quote.quote;

                  //  Show It's Loading
                  if(quoteProvider.isLoading){
                    return const CircularProgressIndicator();
                  }
                  //  Body
                  else{
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // Author Card
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Author:",
                                      style: GoogleFonts.merriweather(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white54
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(quoteProvider.quote.author,
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white70
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        const SizedBox(height: 10),

                        //  Quote Card
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                            child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Quote:",
                                        style: GoogleFonts.merriweather(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                            color: Colors.white54
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(quoteProvider.quote.quote,
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          color: Colors.white70
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                        ),
                        const SizedBox(height: 20),

                        //  Buttons for Favourites / Share
                        CustomButtonRow(
                            author: author,
                            quote: quote,
                        ),

                        const SizedBox(height: 10),

                        //  Button to Display a New Quote
                        ElevatedButton(
                            style: ButtonStyle(
                              side: const MaterialStatePropertyAll<BorderSide>(BorderSide(color: Colors.transparent)),
                              shape: MaterialStatePropertyAll<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueAccent.shade100),
                              foregroundColor: const MaterialStatePropertyAll<Color>(Colors.black),
                              fixedSize: const MaterialStatePropertyAll<Size>(Size.fromWidth(275)),
                            ),
                            onPressed: (){
                              author = '';
                              quote = '';
                              Provider.of<QuoteProvider>(context, listen: false).fetchQuote();
                            },
                            child: Text("Generate Another Quote",
                              style: GoogleFonts.merriweather(
                                  fontWeight: FontWeight.bold
                              ),
                            )
                        ),
                      ],
                    );
                  }
                },
            ),
          )
      ),
    );
  }
}
