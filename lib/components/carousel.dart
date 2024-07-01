import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../utils/app_padding.dart';
import '../utils/app_theme.dart';
import '../utils/cores_personalizadas.dart';

class Carousel extends StatelessWidget {
  final double swidth;

  Carousel(this.swidth, {super.key});

  final List<String> imageCarousel = [
    'assets/images/client.jpg',
    'assets/images/client.jpg',
    'assets/images/client.jpg',
  ];

  final List<String> titleCarousel = [
    'Example Title',
    'Example Title',
    'Example Title',
  ];

  final List<String> nameCarousel = [
    'Example Name',
    'Example Name',
    'Example Name',
  ];

  final List<String> summaryCarousel = [
    'Example Summary',
    'Example Summary',
    'Example Summary',
  ];

  final List<String> partnersLogo = [
    'assets/images/ufrn.png',
    'assets/images/imd.png',
    'assets/images/remne.jpg',
    'assets/images/gilfe.png',
    'assets/images/ppgite.png',
  ];

  final List<double> partnersPadding = [24, 30, 0, 25, 0];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingValues("carouselTop", context),
      child: Column(
        children: [
          if (swidth > 1300) ...[
            Container(
                height: 875,
                width: swidth,
                child: Stack(children: <Widget>[
                  Column(children: [
                    Container(
                        width: swidth,
                        height: 740,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/test.png'),
                              fit: BoxFit.cover),
                        ))
                  ]),
                  Center(
                    child: Container(
                        constraints: BoxConstraints(maxWidth: 1200),
                        padding: paddingValues("sideMainPadding", context),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(height: 140),
                              Container(
                                  child: Text('What Clients Say?',
                                      style: textTheme.labelMedium)),
                              Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    'Here are testimonials from clients..',
                                    style: textTheme.displaySmall,
                                  )),
                              Container(height: 20),
                              SizedBox(
                                  height: 5.0,
                                  width: 82.0,
                                  child: Image.asset('assets/images/img2.jpg',
                                      fit: BoxFit.cover)),
                              SizedBox(height: 40, width: swidth),
                              ImageSlideshow(
                                width: 760,
                                height: 240,
                                initialPage: 0,
                                indicatorColor: CoresPersonalizadas.azulObama,
                                indicatorBackgroundColor: Colors.grey,
                                onPageChanged: (value) {},
                                autoPlayInterval: 3500,
                                isLoop: true,
                                children: [
                                  for (int i = 0;
                                      i < titleCarousel.length;
                                      i++) ...{
                                    Row(children: [
                                      Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      imageCarousel[i]),
                                                  fit: BoxFit.cover))),
                                      Container(width: 20),
                                      Container(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          height: 150,
                                          width: 500,
                                          child: ListView(children: [
                                            Text(titleCarousel[i],
                                                style: textTheme.displayMedium),
                                            Container(height: 35),
                                            Text(nameCarousel[i],
                                                style: textTheme.displaySmall),
                                            Container(height: 20),
                                            Text(summaryCarousel[i],
                                                style: textTheme.displaySmall)
                                          ])),
                                    ]),
                                  },
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 135.0),
                                child: Center(
                                    child: Container(
                                        color: CoresPersonalizadas.azulObama,
                                        height: 150,
                                        width: swidth * 0.9 + 40,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 30),
                                        child: Row(children: [
                                          const SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Icon(
                                                Icons.phone,
                                                size: 70,
                                                color: background,
                                              )),
                                          SizedBox(
                                              height: 100,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text('REQUEST A FREE QUOTE',
                                                        style:
                                                            textTheme.labelMedium),
                                                    Text(
                                                        'Get answers and advice from people you want it from.',
                                                        style: textTheme
                                                            .displayMedium)
                                                  ])),
                                          Spacer(),
                                          TextButton(
                                              style: ButtonStyle(
                                                fixedSize:
                                                    WidgetStatePropertyAll(
                                                        Size(150, 50)),
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                        onPrimary),
                                                overlayColor:
                                                    WidgetStatePropertyAll(
                                                        onPrimary),
                                              ),
                                              onPressed: () {},
                                              child: Text('CONTACT US',
                                                  style: TextStyle(
    color: Colors.white,
    fontSize: 14,
    shadows: [
      Shadow(
        offset: Offset(1, 1),
        color: Color.fromRGBO(0, 0, 0, 0.5),
      )
    ],
  ),)),
                                        ]))),
                              ),
                            ])),
                  ),
                ])),
            Container(
              constraints: BoxConstraints(maxWidth: 1200),
              padding: paddingValues("sideMainPadding", context),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < partnersLogo.length; i++) ...{
                      Container(
                          height: 120,
                          width: 230,
                          padding: EdgeInsets.symmetric(
                              vertical: partnersPadding[i]),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 6,
                                  color: const Color.fromARGB(
                                      255, 231, 228, 228))),
                          child: Image(
                              image: AssetImage(partnersLogo[i]),
                              fit: BoxFit.contain)),
                    },
                  ]),
            )
          ] else ...[
            SizedBox(height: 100, width: swidth),
            SizedBox(
                height: 740,
                width: swidth,
                child:
                    Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                  Column(children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 50),
                        height: 650,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/test.png'),
                              fit: BoxFit.cover),
                        ))
                  ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 40),
                        Container(
                            padding: const EdgeInsets.only(left: 40, top: 50),
                            child: Text('What Clients Say?',
                                style: textTheme.displayLarge)),
                        Container(
                            padding: const EdgeInsets.only(top: 15, left: 40),
                            child: Text(
                              'Here are testimonials from clients..',
                              style: textTheme.displaySmall,
                            )),
                        Container(height: 20),
                        Row(children: [
                          Container(width: 40),
                          SizedBox(
                              height: 5.0,
                              width: 82.0,
                              child: Image.asset('assets/images/img2.jpg',
                                  fit: BoxFit.cover)),
                        ]),
                        SizedBox(height: 40, width: swidth),
                        ImageSlideshow(
                          width: swidth,
                          height: 240,
                          initialPage: 0,
                          indicatorColor: CoresPersonalizadas.azulObama,
                          indicatorBackgroundColor: Colors.grey,
                          onPageChanged: (value) {},
                          autoPlayInterval: 3500,
                          isLoop: true,
                          children: [
                            for (int i = 0; i < titleCarousel.length; i++) ...{
                              Row(children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 40),
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: DecorationImage(
                                            image: AssetImage(imageCarousel[i]),
                                            fit: BoxFit.cover))),
                                Container(
                                    padding: const EdgeInsets.only(left: 30),
                                    height: 100,
                                    width: swidth - 160,
                                    child: ListView(children: [
                                      Text(titleCarousel[i],
                                          style: textTheme.displayMedium),
                                      Container(height: 35),
                                      Text(nameCarousel[i],
                                          style: textTheme.displaySmall),
                                      Container(height: 20),
                                      Text(summaryCarousel[i],
                                          style: textTheme.displaySmall)
                                    ])),
                              ]),
                            },
                          ],
                        )
                      ]),
                  Container(
                      color: CoresPersonalizadas.azulObama,
                      height: 180,
                      width: swidth * 0.95,
                      child: Column(children: [
                        Row(children: [
                          Container(width: 15),
                          const SizedBox(
                              width: 50,
                              height: 100,
                              child: Icon(
                                Icons.phone,
                                size: 40,
                                color: background,
                              )),
                          SizedBox(
                              width: swidth * 0.7,
                              height: 100,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('REQUEST A FREE QUOTE',
                                        style: textTheme.displayMedium),
                                    Text(
                                        'Get answers and advice from people you want ir from.',
                                        style: textTheme.displaySmall)
                                  ]))
                        ]),
                        Container(width: swidth * 0.25),
                        TextButton(
                            style: ButtonStyle(
                              fixedSize:
                                  WidgetStatePropertyAll(Size(150, 50)),
                              backgroundColor:
                                  WidgetStatePropertyAll(onPrimary),
                              overlayColor: WidgetStatePropertyAll(onPrimary),
                            ),
                            onPressed: () {},
                            child: Text('CONTACT US',
                                style: TextStyle(
    color: Colors.white,
    fontSize: 14,
    shadows: [
      Shadow(
        offset: Offset(1, 1),
        color: Color.fromRGBO(0, 0, 0, 0.5),
      )
    ],
  ),)),
                      ])),
                ])),
            SizedBox(width: swidth * 0.9, height: 40),
            SizedBox(
                width: swidth * 0.8,
                child: Center(
                    child: Column(children: [
                  for (int i = 0; i < partnersLogo.length; i++) ...{
                    Container(
                        height: 150,
                        width: 350,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.all(partnersPadding[i]),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 6,
                                color:
                                    const Color.fromARGB(255, 231, 228, 228))),
                        child: Image(
                            image: AssetImage(partnersLogo[i]),
                            fit: BoxFit.contain)),
                  }
                ])))
          ],
          Container(height: 60),
        ],
      ),
    );
  }
}
