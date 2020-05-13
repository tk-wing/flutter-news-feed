import 'package:flutter/material.dart';
import 'package:flutter_news_feed/Provider/providers.dart';
import 'package:flutter_news_feed/view/screens/home_screen.dart';
import 'package:flutter_news_feed/view/style/style.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: globalProviders,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsFeed',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: BoldFont,
      ),
      home: HomeScreen(),
    );
  }
}
