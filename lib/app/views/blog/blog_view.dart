import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_network/image_network.dart';
import 'package:obamahome/app/views/blog/responsividade/blog_desktop.dart';
import 'package:obamahome/app/views/blog/responsividade/blog_mobile.dart';
import 'package:obamahome/app/views/blog/responsividade/blog_tablet.dart';

import '../../../components/loadCircle.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/responsivo.dart';
import '../../controllers/blog_controller.dart';
import '../../models/blog_models.dart';
import 'components/blog-details.dart';

List<IconData> shareMedia = [
  FontAwesomeIcons.facebook,
  FontAwesomeIcons.twitter,
  FontAwesomeIcons.googlePlus,
  FontAwesomeIcons.pinterest,
];

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);
  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool dataAvailable = false;
  String newData = '';
  Key key = UniqueKey();
  late TextStyle titleStyle;
  bool loadPosts = false;
  bool loadObjects = false;

  void updateData(String value) {
    setState(() {
      newData = value;
      key = UniqueKey();
    });
  }

  @override
  void initState() {
    super.initState();
    activateLoad();
    waitData();
  }

  void activateLoad() {
    setState(() {
      loadPosts = true;
    });
  }

  void waitData() async {
    Future.wait([fetchData("")])
        .timeout(Duration(seconds: 5))
        .whenComplete(() => setState(() {
              loadPosts = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            body: Stack(
          children: [
            Responsivo(
                mobile: BlogMobile(
                    newData, key, swidth, updateData, textTheme.titleSmall!),
                tablet: BlogTablet(
                    newData, key, swidth, updateData, textTheme.headlineSmall!),
                desktop: BlogDesktop(newData, key, swidth, updateData,
                    textTheme.headlineSmall!)),
            if (loadPosts) ...{circleLoadSpinner(context)}
          ],
        )));
  }
}

@override
Widget blogListView(BuildContext context, key, swidth, posts) {
  List<BlogModel> post = [...posts];

  return SizedBox(
    height: 850 * (post.length).toDouble(),
    child: Column(children: [
      for (var i = 0; i < post.length; i++) ...{
        SizedBox(
            height: 800,
            width: swidth * .565,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.blue,
                  width: 8,
                ))),
                child: ImageNetwork(
                    key: key,
                    image: post[i].imagePath,
                    width: swidth * .565,
                    height: 400,
                    fitAndroidIos: BoxFit.cover,
                    fitWeb: BoxFitWeb.cover),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text(post[i].title, style: textTheme.titleSmall)),
              Row(children: [
                const Icon(Icons.person, color: Colors.blue, size: 16),
                Container(width: 2),
                Text('Marketing', style: textTheme.labelSmall),
                Container(width: 13),
                const Icon(FontAwesomeIcons.calendarDays,
                    color: Colors.blue, size: 16),
                Container(width: 3),
                Text(post[i].publishedDate, style: textTheme.labelSmall),
              ]),
              Container(
                  width: swidth * 0.6,
                  margin: const EdgeInsets.only(top: 20, bottom: 30),
                  child: Text(post[i].text,
                      maxLines: 5, style: textTheme.headlineMedium)),
              Row(children: [
                Material(
                  color: Colors.blue,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BlogDetails(initialPageIndex: i)));
                      },
                      overlayColor: const WidgetStatePropertyAll(onPrimary),
                      child: SizedBox(
                        width: 170,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'VER MAIS >',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                const Spacer(),
                Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                      Text('Share:', style: textTheme.headlineMedium),
                      Container(width: 5),
                      SizedBox(
                        width: 120,
                        height: 30,
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: shareMedia.length),
                            itemBuilder: (BuildContext context, int mediaId) {
                              return InkWell(
                                  overlayColor: const WidgetStatePropertyAll(
                                      Colors.transparent),
                                  onTap: () {},
                                  child: SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: Icon(shareMedia[mediaId],
                                        size: 15, color: onPrimary),
                                  ));
                            }),
                      )
                    ])),
              ]),
            ]))
      },
    ]),
  );
}
