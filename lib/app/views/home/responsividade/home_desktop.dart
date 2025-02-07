import 'package:flutter/material.dart';
import 'package:obamahome/components/simpleRow.dart';
import 'package:obamahome/templates/template_home.dart';
import 'package:obamahome/utils/cores_personalizadas.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../../components/sectionTitle.dart';
import '../../../../utils/app_padding.dart';
import '../../../../utils/app_theme.dart';
import '../constants.dart';

class HomeDesktop extends StatefulWidget {
  final TrackingScrollController scrollController;
  // final void Function() hidePosts;
  // final void Function() hideObjects;

  HomeDesktop({
    required this.scrollController,
    // required this.hidePosts,
    // required this.hideObjects,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // double paddingCard = MediaQuery.of(context).size.width * .025;
    double swidth = MediaQuery.of(context).size.width;

    return TemplateHome(children: [
      //abaixo do gif
      Container(
        height: 320,
        width: MediaQuery.of(context).size.width,
        padding: paddingValues("mainTitle", context),
        child: SectionTitle(
            'Plataforma OBAMA',
            'Objetos de Aprendizagem para Matemática',
            CrossAxisAlignment.center),
      ),
      Container(
          constraints: BoxConstraints(maxWidth: 1200),
          padding: paddingValues("sideMainPadding", context),
          child: ResponsiveGridRow(
            children: [
              for (int i = 0; i < sectionTitle.length; i++) ...{
                ResponsiveGridCol(
                  lg: 3,
                  md: 6,
                  xs: 12,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ItemProduto(sectionTitle[i], "", sectionImage[i]),
                  ),
                ),
              }
            ],
          )),
      Padding(
        padding: paddingValues("sectionPadding", context),
        child: Stack(
          children: [
            Container(
                width: swidth,
                height: 900,
                color: CoresPersonalizadas.azulObama),
            Container(
                width: swidth * .7,
                height: 900,
                color: const Color.fromARGB(255, 241, 238, 238)),
            Center(
              child: Container(
                  constraints: BoxConstraints(maxWidth: 1200),
                  padding: paddingValues("sideMainPadding", context),
                  child: Padding(
                    padding: paddingValues("sectionPadding", context),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionTitle(
                              'O QUE VOCÊ ENCONTRA AQUI',
                              'Recursos pensados e produzidos para professores que ensinam matemática',
                              CrossAxisAlignment.start),
                          Container(
                              padding: const EdgeInsets.only(top: 60),
                              child: ResponsiveGridRow(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                    child: Icon(grid1Icon[i],
                                                        size: iconSize2[i],
                                                        color: background)),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: Text(grid1Title[i],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!)),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: Text(grid1Content[i],
                                                        style: textTheme
                                                            .bodySmall))
                                              ]),
                                        ),
                                      ),
                                    },
                                  ]))
                        ]),
                  )),
            ),
          ],
        ),
      ),
      // OAHome(swidth),
      // Padding(
      //   padding: paddingValues("carouselTop", context),
      //   child: Stack(
      //     children: [
      //       Container(
      //           width: swidth,
      //           height: 900,
      //           color: CoresPersonalizadas.azulObama),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           Container(
      //               width: swidth * .7,
      //               height: 900,
      //               color: const Color.fromARGB(255, 241, 238, 238),
      //               padding: paddingValues("sideMainPadding", context)),
      //         ],
      //       ),
      //       Center(
      //         child: Container(
      //           constraints: BoxConstraints(maxWidth: 1200),
      //           padding: paddingValues("sectionPadding", context),
      //           child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.end,
      //               children: [
      //                 SectionTitle(
      //                     'OUR FEEDBACK',
      //                     'Easy and effective way to get your device repaired.',
      //                     CrossAxisAlignment.end),
      //                 Container(
      //                     padding: const EdgeInsets.only(top: 60),
      //                     child: ResponsiveGridRow(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           for (int i = 0; i < grid2Title.length; i++) ...{
      //                             ResponsiveGridCol(
      //                               lg: 6,
      //                               sm: 12,
      //                               child: Padding(
      //                                 padding:
      //                                     const EdgeInsets.only(bottom: 100),
      //                                 child: Column(
      //                                     crossAxisAlignment:
      //                                         CrossAxisAlignment.end,
      //                                     children: [
      //                                       Container(
      //                                           height: 100,
      //                                           width: 100,
      //                                           decoration: BoxDecoration(
      //                                               color: Theme.of(context)
      //                                                   .primaryColor,
      //                                               borderRadius:
      //                                                   BorderRadius.circular(
      //                                                       100)),
      //                                           child: Icon(grid2Icon[i],
      //                                               size: iconSize2[i],
      //                                               color: background)),
      //                                       Container(
      //                                           padding: const EdgeInsets.only(
      //                                               top: 20),
      //                                           child: Text(grid2Title[i],
      //                                               style:
      //                                                   textTheme.titleSmall!)),
      //                                       Container(
      //                                           padding: const EdgeInsets.only(
      //                                               top: 20),
      //                                           child: Text(grid2Content[i],
      //                                               style: textTheme.bodySmall))
      //                                     ]),
      //                               ),
      //                             ),
      //                           },
      //                         ]))
      //               ]),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // BlogHome(swidth)
    ]);
  }
}
