import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_quotes_generator/pages/splashpage.dart';
import 'package:random_quotes_generator/providers/isar_provider.dart';
import 'package:random_quotes_generator/providers/quote_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await IsarProvider.initializeDatabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<QuoteProvider>(
          create: (_) => QuoteProvider(),
        ),
        ChangeNotifierProvider<IsarProvider>(
            create: (_) => IsarProvider(),
        ),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
