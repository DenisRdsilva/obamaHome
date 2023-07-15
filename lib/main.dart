import 'package:flutter/material.dart';

import 'pages/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
      home: HomePage(),
      initialRoute: '/',
    );
  }
}