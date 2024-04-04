class Quote {
  late String author;
  late String quote;

  Quote({
    required this.author,
    required this.quote,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {

    String sanitizedQuote = json['quote'].replaceAll('"', '\'');
    if (sanitizedQuote.endsWith('@')) {
      sanitizedQuote = sanitizedQuote.substring(0, sanitizedQuote.length - 1);
    }

    return Quote(
      author: json['author'],
      quote: sanitizedQuote,
    );
  }
}