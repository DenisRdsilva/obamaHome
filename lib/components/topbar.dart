import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:obamahome/components/launchSocialMedia.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cores_personalizadas.dart';

// ignore: must_be_immutable
class TopBar extends StatelessWidget {
  double swidth;

  TopBar(this.swidth, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (swidth > 1150) ...[
        Container(
            color:CoresPersonalizadas.azulObama,
            height: 45.0,
            width: swidth,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 550,
                      margin: EdgeInsets.only(left: swidth * 0.068),
                      child: Row(children: [
                        Container(
                            child: Row(children: [
                          Container(
                              padding: const EdgeInsets.only(right: 10),
                              child: const Icon(FontAwesomeIcons.house,
                                  color: Colors.white, size: 13)),
                          const Text(
                              'Av. Cap. Mor Gouveia, 3000 - Lagoa Nova, Natal - RN',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.0)),
                        ])),
                        Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(CoresPersonalizadas.azulObama),
                              ),
                              onPressed: () {
                                launchUrl(emailLaunchUri);
                              },
                              child: Row(children: [
                                Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: const Icon(FontAwesomeIcons.envelope,
                                        color: Colors.white, size: 16)),
                                const Text('obama@imd.ufrn.br',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13.0)),
                              ]),
                            ))
                      ])),
                  const Spacer(),
                  Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        SocialMedia(Colors.white),
                        Container(
                            margin: EdgeInsets.only(
                                left: 15.0, right: swidth * 0.068),
                            height: 45,
                            width: 160,
                            child: Material(
                              color: Colors.white,
                              textStyle: const TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                              child: InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                    width: swidth * 0.154,
                                    height: 45,
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Acesse',
                                            textAlign: TextAlign.center)
                                      ],
                                    ),
                                  )),
                            ))
                      ]))
                ]))
      ],
      if (swidth < 1150) ...[
        if (swidth > 900) ...[
          Container(
              color:CoresPersonalizadas.azulObama,
              height: 80.0,
              width: swidth,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   child: const Text('HOME',
                    //       style:
                    //           TextStyle(color: Colors.white, fontSize: 20.0)),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: swidth * 0.04, right: swidth * 0.04),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(child: SocialMedia(Colors.white)),
                            SizedBox(
                                height: 45,
                                width: 160,
                                child: Material(
                                  color: Colors.white,
                                  textStyle: const TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                  child: InkWell(
                                      onTap: () {},
                                      child: SizedBox(
                                        width: swidth * 0.154,
                                        height: 45,
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Acesse',
                                                textAlign: TextAlign.center)
                                          ],
                                        ),
                                      )),
                                ))
                          ]),
                    )
                  ])),
        ],
      ],
      if (swidth < 900) ...[
        Container(
          color: CoresPersonalizadas.azulObama,
          width: swidth,
          height: 110,
          child:
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
            // Container(
            //   child: const Text('HOME',
            //       style: TextStyle(color: Colors.white, fontSize: 20.0)),
            // ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialMedia(Colors.white),
              ],
            ),
            SizedBox(
                height: 35,
                width: 210,
                child: Material(
                  color: Colors.white,
                  textStyle:
                      const TextStyle(color: Colors.black, fontSize: 16.0),
                  child: InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: swidth * 0.154,
                        height: 45,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Acesse', textAlign: TextAlign.center)
                          ],
                        ),
                      )),
                ))
          ]),
        )
      ],
    ]);
  }
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'obama@imd.ufrn.br',
  query: encodeQueryParameters(<String, String>{
    'subject': '',
  }),
);
