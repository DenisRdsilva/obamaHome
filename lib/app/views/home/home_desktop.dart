import 'package:flutter/material.dart';
import 'package:obamahome/app/views/home/components/firstSectionHome.dart';
import 'package:obamahome/components/drawer.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../components/carousel.dart';
import '../../../components/footer.dart';
import '../../../components/navMenu.dart';
import '../../../components/sectionTitle.dart';
import '../../../components/topbar.dart';
import 'components/our_product_item.dart';
import 'constants.dart';
import 'home_view.dart';

class HomeDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;
  final bool postAvailable;
  final bool objectAvailable;
  final List<dynamic> posts;
  final List<dynamic> objects;

  const HomeDesktop({
    required this.scrollController,
    required this.postAvailable,
    required this.objectAvailable,
    required this.posts,
    required this.objects,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatefulWidget(
          scrollController: scrollController,
          postAvailable: postAvailable,
          objectAvailable: objectAvailable,
          posts: posts,
          objects: objects),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  final TrackingScrollController scrollController;
  final bool postAvailable;
  final bool objectAvailable;
  final List<dynamic> posts;
  final List<dynamic> objects;

  const MyStatefulWidget({
    required this.scrollController,
    required this.postAvailable,
    required this.objectAvailable,
    required this.posts,
    required this.objects,
    Key? key,
  }) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double paddingCard = MediaQuery.of(context).size.width * .025;
    double swidth = MediaQuery.of(context).size.width;

    return Scaffold(
        key: scaffoldKey,
        drawer: const drawermenu(),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: <Widget>[
              TopBar(swidth),

              if (swidth >= 1360) ...[
                Container(
                    width: swidth,
                    height: 125,
                    margin: EdgeInsets.only(
                        left: swidth * 0.068, right: swidth * 0.068),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 250,
                              child: Image.asset('assets/images/logo.png',
                                  fit: BoxFit.fitHeight)),
                          NavMenu(
                              swidth: swidth,
                              eixoLista: Axis.horizontal,
                              heightBtn: 50),
                        ])),
              ] else ...[
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 125,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              child:
                                  const Icon(Icons.menu, color: Colors.black),
                              onPressed: () =>
                                  scaffoldKey.currentState?.openDrawer()),
                          Container(
                              width: 280,
                              padding:
                                  const EdgeInsets.only(right: 30, left: 30),
                              child: Image.asset('assets/images/logo.png',
                                  fit: BoxFit.fitHeight)),
                        ]))
              ],

              // box com gif da foto tela inicial
              SizedBox(
                  width: swidth,
                  height: 660,
                  // color: Colors.grey,
                  child: Image.asset("assets/images/animate.gif",
                      fit: BoxFit.cover)),

              //abaixo do gif
              Container(
                height: 320,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 120.0, bottom: 65.0),
                child: SectionTitle(
                    'Plataforma OBAMA',
                    'Objetos de Aprendizagem para Matemática',
                    CrossAxisAlignment.center),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: swidth * .05),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Expanded(
                    child: ResponsiveGridRow(
                      children: [
                        for (int i = 0; i < sectionTitle.length; i++) ...{
                          ResponsiveGridCol(
                            lg: 3,
                            md: 6,
                            xs: 12,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: ItemProduto("Data Recovery",
                                  "nononon nono nonon non !", "i1.png"),
                            ),
                          ),
                        }
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 100, bottom:  120),
                child: ResponsiveGridRow(children: [
                  ResponsiveGridCol(
                    lg: 8,
                    sm: 12,
                    child: Container(
                        color: const Color.fromARGB(255, 241, 238, 238),
                        padding: const EdgeInsets.only(top: 110, left: 90),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionTitle(
                                  'ABOUT SERVICE',
                                  'Easy and effective way to get your device repaired.',
                                  CrossAxisAlignment.start),
                              Container(
                                  padding: const EdgeInsets.only(top: 60),
                                  child: ResponsiveGridRow(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (int i = 0;
                                            i < grid1Title.length;
                                            i++) ...{
                                          ResponsiveGridCol(
                                            lg: 6,
                                            sm: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 100),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100)),
                                                        child: Icon(
                                                            grid1Icon[i],
                                                            size: iconSize2[i],
                                                            color:
                                                                Colors.white)),
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 20),
                                                        child: Text(
                                                            grid1Title[i],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall!)),
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 20),
                                                        child: Text(
                                                            grid1Content[i],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayMedium!))
                                                  ]),
                                            ),
                                          ),
                                        },
                                      ]))
                            ])),
                  ),
                  if (swidth > 992) ...{
                    ResponsiveGridCol(
                      lg: 4,
                      child: SizedBox(
                          height: 853,
                          child: Image.asset('assets/images/img2.jpg',
                              fit: BoxFit.cover)),
                    ),
                  }
                ]),
              ),
              if (widget.objectAvailable == false) ...{
                Container(
                  margin: const EdgeInsets.only(bottom: 65.0),
                  child: SectionTitle(
                      'OBJETOS DE APRENDIZAGEM', 'Mais populares', CrossAxisAlignment.center),
                ),
                // if (MediaQuery.of(context).size.width > 1000) ...[
                Padding(
                  padding: EdgeInsets.only(
                      left: swidth * .05, right: swidth * .05, bottom: 120),
                  child: ResponsiveGridRow(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (var lista in widget.objects) ...{
                        ResponsiveGridCol(
                          lg: 3,
                          md: 6,
                          xs: 12,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: paddingCard, vertical: 15),
                            child: OurProductItem(
                              title: lista['nome'],
                              image: lista['url'],
                            ),
                          ),
                        ),
                      }
                    ],
                  ),
                ),
              },
              ResponsiveGridRow(children: [
                if (swidth > 992) ...{
                  ResponsiveGridCol(
                    lg: 4,
                    child: SizedBox(
                        height: 853,
                        child: Image.asset('assets/images/img2.jpg',
                            fit: BoxFit.cover)),
                  ),
                },
                ResponsiveGridCol(
                  lg: 8,
                  sm: 12,
                  child: Container(
                      color: const Color.fromARGB(255, 241, 238, 238),
                      padding: const EdgeInsets.only(top: 110, right: 90),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SectionTitle(
                                'OUR FEEDBACK',
                                'Easy and effective way to get your device repaired.',
                                CrossAxisAlignment.end),
                            Container(
                                padding: const EdgeInsets.only(top: 60),
                                child: ResponsiveGridRow(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i < grid2Title.length;
                                          i++) ...{
                                        ResponsiveGridCol(
                                          lg: 6,
                                          sm: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 100),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100)),
                                                      child: Icon(grid2Icon[i],
                                                          size: iconSize2[i],
                                                          color: Colors.white)),
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      child: Text(grid2Title[i],
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleSmall!)),
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      child: Text(
                                                          grid2Content[i],
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium!))
                                                ]),
                                          ),
                                        ),
                                      },
                                    ]))
                          ])),
                ),
              ]),
              if (widget.postAvailable == false) ...{
                Padding(
                  padding: const EdgeInsets.only(top: 120, left: 74, right: 74),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SectionTitle('Últimos posts do blog', '',
                                CrossAxisAlignment.start),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: ResponsiveGridRow(
                          children: [
                            for (int i = 0; i < widget.posts.length; i++) ...{
                              ResponsiveGridCol(
                                  lg: 4,
                                  md: 6,
                                  xs: 12,
                                  child: blogData(context, i, widget.posts)),
                            }
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              },
              Carousel(swidth),
              Footer(swidth),
            ])));
  }
}