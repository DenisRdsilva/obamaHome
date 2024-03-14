import 'package:flutter/material.dart';
import 'package:obamahome/components/mainButton.dart';
import 'package:obamahome/utils/cores_personalizadas.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '/../../../../components/bannerSuperior.dart';
import '../../../../components/carousel.dart';
import '../../../../components/drawer.dart';
import '../../../../components/footer.dart';
import '../../../../components/menuMobile.dart';
import '../../../../components/navMenu.dart';
import '../../../../components/sectionTitle.dart';
import '../../../../components/topbar.dart';
import '../../../../utils/app_theme.dart';
import '../constants.dart';

class TrilhasTablet extends StatelessWidget {
  const TrilhasTablet({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: MyStatefulWidget());
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    return Scaffold(
        key: scaffoldKey,
        drawer: const drawermenu(),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
                child: Column(children: <Widget>[
              TopBar(swidth),
              Column(children: [
                if (MediaQuery.of(context).size.width > 1360) ...[
                  Container(
                      width: swidth,
                      height: 125,
                      margin: EdgeInsets.only(
                          left: swidth * 0.068, right: swidth * 0.06),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 250,
                                child: Image.asset('assets/images/logo.png',
                                    fit: BoxFit.fitHeight)),
                            NavMenu(
                                swidth: swidth,
                                heightBtn: 50),
                          ])),
                ] else ...[
                 menuMobile(context, scaffoldKey, swidth),
                ],
                BannerSuperior(context, 'Trilhas'),
                // Padding(
                //   padding: const EdgeInsets.only(top: 120.0, bottom: 65.0),
                //   child: SectionTitle(
                //       'Plataforma OBAMA',
                //       'Objetos de Aprendizagem para Matemática',
                //       CrossAxisAlignment.center),
                // ),
                Container(
                    margin: const EdgeInsets.only(top: 120),
                    width: swidth,
                    color: CoresPersonalizadas.azulObama,
                    child: ResponsiveGridRow(children: [
                      ResponsiveGridCol(
                        lg: 8,
                        sm: 12,
                        child: Container(
                            color: const Color.fromARGB(255, 241, 238, 238),
                            padding: EdgeInsets.only(right: 90, left: 90),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 110),
                                    child: SectionTitle(
                                        'Trilhas de aprendizagem',
                                        'Como o nome já diz, as trilhas que você acessará aqui são dicas para seguir um caminho e conhecer as principais funcionalidades das mais importantes ferramentas do Google que podem te auxiliar no processo de ensino remoto. Ah, e nós já trilhamos o caminho das pedras por você. Então agora basta você ir respondendo às perguntas, quando houver, e seguir as instruções. Bons estudos!',
                                        CrossAxisAlignment.start),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(top: 60),
                                      child: ResponsiveGridRow(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (int i = 0;
                                                i < sectionImage.length;
                                                i++) ...{
                                              ResponsiveGridCol(
                                                lg: 6,
                                                sm: 12,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 100),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(bottom: 25),
                                                          child: ClipOval(
                                                              child: Container(
                                                                color: background,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child: Image.asset(
                                                              "assets/images/" +
                                                                  sectionImage[i],
                                                              fit: BoxFit.contain,
                                                              width: 130,
                                                              height: 130,
                                                            ),
                                                          )),
                                                        ),
                                                        // Image.asset(
                                                        //     "assets/images/" +
                                                        //         sectionImage[i],
                                                        //     width: 200, height: 200, ),
                                                        mainButton(
                                                            context,
                                                            "Acessar Trilha",
                                                            sectionLinks[i], null)
                                                      ]),
                                                ),
                                              ),
                                            },
                                          ]))
                                ])),
                      ),
                    ])),
                Carousel(swidth),
                Footer(swidth),
              ]),
            ]))));
  }
}