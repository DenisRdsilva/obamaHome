import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_network/image_network.dart';
import 'package:obamahome/templates/template_basic_row.dart';

import '../../../../components/loadCircle.dart';
import '../../../../utils/app_theme.dart';
import '../../../controllers/blog_controller.dart';
import '../../../models/blog_models.dart';
import '../blog_view.dart';
import 'blog-filters.dart';

class BlogDetails extends ConsumerStatefulWidget {
  final int initialPageIndex;

  const BlogDetails({Key? key, required this.initialPageIndex})
      : super(key: key);

  @override
  _MyStatefulWidgetState createState() =>
      _MyStatefulWidgetState(pageIndex: initialPageIndex);
}

class _MyStatefulWidgetState extends ConsumerState<BlogDetails> {
  int pageIndex;
  _MyStatefulWidgetState({required this.pageIndex});
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _pageController;
  String newData = '';
  Key key = UniqueKey();
  bool loadPosts = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void updateData(String value) {
    setState(() {
      newData = value;
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
    var pageArgs;
    double swidth = MediaQuery.of(context).size.width;
    if (ModalRoute.of(context)!.settings.arguments == null) {
      pageArgs = 0;
    } else {
      pageArgs = ModalRoute.of(context)!.settings.arguments;
    }

    _pageController = PageController(initialPage: pageArgs);

    return Stack(
      children: [
        TemplateRow(children: [
          FutureBuilder<void>(
            future: BlogController().updateBlogContent(ref, newData),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final blogDataList = ref.watch(blogPosts);
                List<BlogModel?> datas = [...blogDataList];
                return Column(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    blogPageView(context, swidth, _pageController, datas),
                    Container(
                        padding: const EdgeInsets.only(top: 85.0, left: 15),
                        width: swidth * .295,
                        child: blogFilters(context, swidth, datas, updateData, textTheme.titleSmall!)),
                  ])
                ]);
              } else if (snapshot.hasError) {
                Container(
                    padding: const EdgeInsets.only(top: 100, left: 90, right: 15),
                    width: swidth * 0.67,
                    child: Text(
                      "Perdão, não há nenhum post a ser exibido no momento.",
                    ));
              }
              return Container();
              // return circleLoadSpinner(context);
            },
          ),
        ]),
        if (loadPosts) ...{circleLoadSpinner(context)}
      ],
    );
  }
}

Widget blogPageView(context, swidth, _pageController, datas) {
  return Container(
    padding: const EdgeInsets.only(top: 100, right: 15),
    width: swidth * 0.565,
    height: 1400,
    child: PageView.builder(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: datas.length,
      itemBuilder: (BuildContext context, int index) {
        final item = datas[index];

        final prevItem = index > 0 ? datas[index - 1] : null;
        final nextItem = index < datas.length - 1 ? datas[index + 1] : null;

        String previmagePath = prevItem != null ? prevItem.imagePath : "";
        String nextimagePath = nextItem != null ? nextItem.imagePath : "";

        return Column(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.blue,
              width: 8,
            ))),
            child: ImageNetwork(
                image: item!.imagePath,
                width: swidth * .6,
                height: 400,
                fitAndroidIos: BoxFit.cover,
                fitWeb: BoxFitWeb.cover),
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(item.title, style: textTheme.titleSmall)),
          Row(children: [
            const Icon(Icons.person, color: Colors.blue, size: 16),
            Container(width: 2),
            Text('Marketing', style: textTheme.labelSmall),
            Container(width: 13),
            const Icon(FontAwesomeIcons.calendarDays,
                color: Colors.blue, size: 16),
            Container(width: 3),
            Text(item.publishedDate, style: textTheme.labelSmall),
          ]),
          Container(
              width: swidth * 0.6,
              margin: const EdgeInsets.only(top: 20, bottom: 30),
              child: Text(item.text, style: textTheme.headlineMedium)),
          Row(children: [
            Container(),
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
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            if (index > 0 && previmagePath != "") ...{
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageNetwork(image: previmagePath, width: 150, height: 100),
                  InkWell(
                    onTap: () {
                      if (_pageController.hasClients) {
                        _pageController.animateToPage(
                          index - 1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text('< Anterior', style: textTheme.headlineSmall),
                  ),
                  Container(),
                ],
              ),
            },
            if (index < datas.length - 1 && nextimagePath != "") ...{
              Container(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ImageNetwork(image: nextimagePath, width: 150, height: 100),
                  InkWell(
                    onTap: () {
                      if (_pageController.hasClients) {
                        _pageController.animateToPage(
                          index + 1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text('Próximo >', style: textTheme.headlineSmall),
                  )
                ],
              ),
            }
          ]),
        ]);
      },
    ),
  );
}
