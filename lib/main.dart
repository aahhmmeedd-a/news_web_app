import 'package:flutter/material.dart';

import './news_block.dart';
import './news_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
