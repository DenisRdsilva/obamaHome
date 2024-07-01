import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/app_theme.dart';
import '../../../../utils/cores_personalizadas.dart';

List<IconData> SocialMediaLinks = [
  (FontAwesomeIcons.facebook),
  (FontAwesomeIcons.googlePlus),
  (FontAwesomeIcons.twitter),
  (FontAwesomeIcons.linkedin),
  (FontAwesomeIcons.instagram),
];

class StaffCard extends StatelessWidget {
  final String staffName;
  final String staffImg;
  final double swidth;

  StaffCard(this.staffName, this.staffImg, this.swidth, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Material(
        color: terciary,
        child: InkWell(
          onTap: () {},
          mouseCursor: SystemMouseCursors.basic,
          overlayColor:
              const WidgetStatePropertyAll(CoresPersonalizadas.azulObama),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(1),
                  width: 271,
                  height: 271,
                  child: Image.asset(staffImg,
                      fit: BoxFit.cover, alignment: Alignment.topCenter)),
              Container(
                width: 271,
                padding: const EdgeInsets.only(top: 30, bottom: 25),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(staffName, style: textTheme.bodyLarge),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (int i = 0;
                                i < SocialMediaLinks.length;
                                i++) ...{
                              SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Material(
                                    color: onSecondary,
                                    child: InkWell(
                                        onTap: () {},
                                        child: Icon(SocialMediaLinks[i],
                                            size: 16.0, color: onPrimary)),
                                  )),
                            }
                          ])
                    ]),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
