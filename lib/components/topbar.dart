import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obamahome/components/launchSocialMedia.dart';
import 'package:obamahome/utils/app_padding.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app_theme.dart';
import '../utils/cores_personalizadas.dart';

// ignore: must_be_immutable
class TopBar extends StatefulWidget {
  double swidth;

  TopBar(this.swidth, {super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  // var user;

  @override
  void initState() {
    // user = GoogleSignIn().isSignedIn();
    super.initState();
  }

  void checkAuth(context) {
    Navigator.pushNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (widget.swidth > 1150) ...[
        Container(
            color: CoresPersonalizadas.azulObama,
            padding: paddingValues("sideMainPadding", context),
            height: 44.0,
            width: widget.swidth,
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 1200),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
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
                      ]),
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                            SocialMedia(background),
                            Container(
                                height: 45,
                                width: 160,
                                child: Material(
                                  color: background,
                                  textStyle: textTheme.headlineMedium,
                                  child: InkWell(
                                      onTap: () {
                                        checkAuth(context);
                                      },
                                      child: SizedBox(
                                        width: widget.swidth * 0.154,
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
                    ]),
              ),
            ))
      ],
      if (widget.swidth < 1150) ...[
        if (widget.swidth > 900) ...[
          Container(
              color: CoresPersonalizadas.azulObama,
              height: 80.0,
              width: widget.swidth,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: widget.swidth * 0.04,
                          right: widget.swidth * 0.04),
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
                                      onTap: () {
                                        checkAuth(context);
                                      },
                                      child: SizedBox(
                                        width: widget.swidth * 0.154,
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
      if (widget.swidth < 900) ...[
        Container(
          color: CoresPersonalizadas.azulObama,
          width: widget.swidth,
          height: 130,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: const Icon(FontAwesomeIcons.house,
                      color: background, size: 13)),
              Text('Av. Cap. Mor Gouveia, 3000 - Lagoa Nova, Natal - RN',
                  style: GoogleFonts.raleway(color: background, fontSize: 13)),
            ]),
            Container(
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          CoresPersonalizadas.azulObama),
                    ),
                    onPressed: () {
                      launchUrl(emailLaunchUri);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: const Icon(FontAwesomeIcons.envelope,
                                    color: background, size: 16)),
                            Text('obama@imd.ufrn.br',
                                style: GoogleFonts.raleway(
                                    color: background, fontSize: 13)),
                          ]),
                    ))),
            Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // SocialMedia(background),
                  Material(
                    color: background,
                    textStyle: textTheme.headlineMedium,
                    child: InkWell(
                        onTap: () {
                          checkAuth(context);
                        },
                        child: SizedBox(
                          width: 190,
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
                  )
                ],
              ),
            ),
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
