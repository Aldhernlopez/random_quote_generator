import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareQuoteButton extends StatelessWidget {
  const ShareQuoteButton({
    super.key,
    required this.author,
    required this.quote,
  });

  final String author;
  final String quote;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
        _launchEmail(context);
        //debugPrint('Share Button Pressed');
      },
      child: const Icon(Icons.share),
    );
  }

  void _launchEmail(BuildContext context) async{
    final Uri emailURI = Uri(
      scheme: 'mailto',
      path: '',
      queryParameters: {
        'subject': 'Check out this Quote by $author!',
        'body': '"$quote"',
      }
    );

    if(await canLaunchUrl(emailURI)){
      await launchUrl(emailURI);
    }
  }
}
