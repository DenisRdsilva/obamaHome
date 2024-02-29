import 'dart:convert';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchData(String searchTerm) async {
  final response = await http.get(Uri.parse('http://localhost:3000/dados'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final postsFiltrados = filtrarPosts(jsonData, searchTerm);
    final posts = postsFiltrados
        .map((item) => {
              'title': item['title'],
              'text': item['text'],
              'summary': item['summary'],
              'content': item['content'],
              'published_date': item['published_date'],
            })
        .toList()
        .reversed
        .toList();
    return posts;
  } else {
    return [];
  }
}

List<dynamic> filtrarPosts(List<dynamic> jsonData, String searchTerm) {
  if (searchTerm.isEmpty) {
    return jsonData;
  }

  return jsonData.where((item) {
    final title = item['title'].toString().toLowerCase();
    final text = item['text'].toString().toLowerCase();
    final summary = item['summary'].toString().toLowerCase();
    final content = item['content'].toString().toLowerCase();

    return title.contains(searchTerm.toLowerCase()) ||
        text.contains(searchTerm.toLowerCase()) ||
        summary.contains(searchTerm.toLowerCase()) ||
        content.contains(searchTerm.toLowerCase());
  }).toList();
}

String extractImagePath(String content) {
  final document = parse(content);
  final imgElement = document.getElementsByTagName('img').last;
  final result = imgElement.attributes['src'];
  return result!;
}

String extractSummaryPath(String summary) {
  final document = parse(summary);
  final sumElement = document.getElementsByTagName('p').last;
  final sumValue = sumElement.text;
  return sumValue;
}