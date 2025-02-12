import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import 'modalSearch.dart';

menuMobile(context, scaffoldKey, swidth) {
  return SizedBox(
      width: swidth,
      height: 125,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        MenuItemButton(
            child: const Icon(Icons.menu, color: onPrimary),
            onPressed: () => scaffoldKey.currentState?.openDrawer()),
        Container(
            width: 190,
            margin: const EdgeInsets.only(right: 10, left: 10),
            child:
                Image.asset('assets/images/logo.png', fit: BoxFit.fitHeight)),
        SizedBox(
          width: 42,
          height: 40,
          child: SearchDialog(swidth: swidth, searchText: '', isHovered: false),
        ),
      ]));
}
