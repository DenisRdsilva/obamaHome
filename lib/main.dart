import 'package:flutter/material.dart';
import 'package:obamahome/pages/blog/blog-details.dart';
import 'package:obamahome/pages/home/home1.dart';

import 'pages/about-us/aboutUs.dart';
import 'pages/blog/blog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
      home: const HomePage1(),
      initialRoute: '/',
      routes: {
        '/aboutus' : (context) => const AboutUsPage(),
        '/blog' : (context) => const BlogPage(),
        '/blog-details' : (context) => const BlogDetails(),
      }
    );
  }
}