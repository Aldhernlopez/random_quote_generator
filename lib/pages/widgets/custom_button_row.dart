import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_quotes_generator/pages/widgets/share_button.dart';
import 'package:random_quotes_generator/providers/isar_provider.dart';

class CustomButtonRow extends StatelessWidget {
  const CustomButtonRow({
    super.key,
    required this.author,
    required this.quote,
  });

  final String author;
  final String quote;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            side: const MaterialStatePropertyAll<BorderSide>(BorderSide(color: Colors.white)),
            shape: MaterialStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            backgroundColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
            fixedSize: const MaterialStatePropertyAll<Size>(Size.fromWidth(125)),
          ),
            onPressed: (){
            final provider = Provider.of<IsarProvider>(context, listen: false);
            provider.addFavorite(author, quote);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Added to Favorite Quotes!"),
                ),
            );
            },
            child: const Icon(Icons.star_border_purple500),
        ),
        const SizedBox(width: 25),
        ShareQuoteButton(
            author: author,
            quote: quote,
        ),
      ],
    );
  }
}
