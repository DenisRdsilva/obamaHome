import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obamahome/components/launchSocialMedia.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app_theme.dart';
import '../utils/cores_personalizadas.dart';

// ignore: must_be_immutable
class TopBar extends StatelessWidget {
  double swidth;

  TopBar(this.swidth, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (swidth > 1150) ...[
        Container(
            color: CoresPersonalizadas.azulObama,
            height: 45.0,
            width: swidth,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: swidth * 0.068),
                      child: Row(children: [
                        Container(
                            child: Row(children: [
                          Container(
                              padding: const EdgeInsets.only(right: 10),
                              child: const Icon(FontAwesomeIcons.house,
                                  color: background, size: 13)),
                          Text(
                              'Av. Cap. Mor Gouveia, 3000 - Lagoa Nova, Natal - RN',
                              style: GoogleFonts.raleway(
                                  color: background, fontSize: 13)),
                        ])),
                        Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    CoresPersonalizadas.azulObama),
                              ),
                              onPressed: () {
                                launchUrl(emailLaunchUri);
                              },
                              child: Row(children: [
                                Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: const Icon(FontAwesomeIcons.envelope,
                                        color: background, size: 16)),
                                Text('obama@imd.ufrn.br',
                                    style: GoogleFonts.raleway(
                                        color: background, fontSize: 13)),
                              ]),
                            ))
                      ])),
                  const Spacer(),
                  Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        SocialMedia(background),
                        Container(
                            margin: EdgeInsets.only(
                                left: 15.0, right: swidth * 0.068),
                            height: 45,
                            width: 160,
                            child: Material(
                              color: background,
                              textStyle: textTheme.headlineMedium,
                              child: InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                    width: swidth * 0.154,
                                    height: 45,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Acesse',
                                            style: textTheme.headlineSmall,
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
              color: CoresPersonalizadas.azulObama,
              height: 80.0,
              width: swidth,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: swidth * 0.04, right: swidth * 0.04),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(child: SocialMedia(background)),
                            SizedBox(
                                height: 45,
                                width: 160,
                                child: Material(
                                  color: background,
                                  textStyle: textTheme.headlineMedium,
                                  child: InkWell(
                                      onTap: () {},
                                      child: SizedBox(
                                        width: swidth * 0.154,
                                        height: 45,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Acesse',
                                                style: textTheme.headlineSmall,
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialMedia(background),
                  ],
                ),
                SizedBox(
                    height: 35,
                    width: 210,
                    child: Material(
                      color: background,
                      textStyle: textTheme.headlineMedium,
                      child: InkWell(
                          onTap: () {},
                          child: SizedBox(
                            width: swidth * 0.154,
                            height: 45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Acesse',
                                    style: textTheme.headlineSmall,
                                    textAlign: TextAlign.center)
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
