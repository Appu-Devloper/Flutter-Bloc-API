import 'package:bhagvadgita/ui/chapterpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Constants/translationprovider.dart';

void main() {
  runApp(  ChangeNotifierProvider(
      create: (context) => TranslationProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Mahabharata',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChapterPage(),
     
    );
  }
}
