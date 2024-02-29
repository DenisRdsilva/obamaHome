import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:obamahome/app/views/home/home_desktop.dart';
import 'package:obamahome/app/views/home/home_mobile1.dart';
import 'package:obamahome/app/views/home/home_tablet.dart';
import 'package:obamahome/app/views/home/responsivo.dart';

import '../../controllers/home_controllers.dart';

Widget blogData(BuildContext context, index, datas) {
  double imageWidth = MediaQuery.of(context).size.width * .3;
  double imageHeight = 185;

  final item = datas[index];

  String extractImagePath(String content) {
    final document = parse(content);
    final imgElement = document.getElementsByTagName('img').last;
    final result = imgElement.attributes['src'];
    return result!;
  }

  String imagePath = extractImagePath(item['content']);

  String pubDate = item['published_date'];
  DateTime dateTime = DateTime.parse(pubDate);
  String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

  // String sumValue = extractSummaryPath(item['summary']);
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(imagePath,
            height: imageHeight, width: imageWidth, fit: BoxFit.cover),
        // Text(imagePath),
        Row(
          children: [
            const Icon(Icons.access_time, size: 16),
            Text(formattedDate, style: const TextStyle(fontSize: 14)),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(item['title'],
              style: Theme.of(context).textTheme.titleSmall!),
        ),
        Text(item['text'],
            style: Theme.of(context).textTheme.displaySmall!, maxLines: 4),
        // Text(sumValue),
      ],
    ),
  );
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomeView> {
  final TrackingScrollController _scrollController = TrackingScrollController();

  List<dynamic> posts = [];
  List<dynamic> objects = [];
  bool postAvailable = true;
  bool objectAvailable = true;

  // Future<void> fetchDataAndUpdateState() async {
  //   final fetchedPosts = await fetchPosts('');
  //   final fetchedObjects = await fetchObjects('');
  //   setState(() {
  //     if (fetchedPosts.isNotEmpty) {
  //       postAvailable = false;
  //       posts = fetchedPosts;
  //     } else {
  //       postAvailable = true;
  //     }
  //     if (fetchedObjects.isNotEmpty) {
  //       objectAvailable = false;
  //       objects = fetchedObjects;
  //     } else {
  //       objectAvailable = true;
  //     }
  //   });
  // }

  Future<void> fetchandUpdatePosts() async {
    final fetchedPosts = await fetchPosts('');
    setState(() {
      if (fetchedPosts.isNotEmpty) {
        postAvailable = false;
        posts = fetchedPosts;
      } else {
        postAvailable = true;
      }
    });
  }

  Future<void> fetchandUpdateObjects() async {
    final fetchedObjects = await fetchObjects('');
    setState(() {
      if (fetchedObjects.isNotEmpty) {
        objectAvailable = false;
        objects = fetchedObjects;
      } else {
        objectAvailable = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // fetchDataAndUpdateState();
    fetchandUpdatePosts();
    fetchandUpdateObjects();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Responsivo(
              mobile: HomeMobile1(
                  postAvailable: postAvailable,
                  objectAvailable: objectAvailable,
                  posts: posts,
                  objects: objects),
              //mobile: HomeMobile( scrollController: _scrollController,),
              tablet: HomeTablet(
                  scrollController: _scrollController,
                  postAvailable: postAvailable,
                  objectAvailable: objectAvailable,
                  posts: posts,
                  objects: objects),
              desktop: HomeDesktop(
                  scrollController: _scrollController,
                  postAvailable: postAvailable,
                  objectAvailable: objectAvailable,
                  posts: posts,
                  objects: objects)),
        ));
  }
}