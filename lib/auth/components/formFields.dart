import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/app_theme.dart';

Widget formFieldNoHide(context, String formLabel) {
  return TextFormField(
    decoration: InputDecoration(
        filled: true,
        label: Text(formLabel),
        labelStyle: textTheme.bodySmall,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        fillColor: textFieldBackground,
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: secondary))),
  );
}

Widget formFieldHidden(context, String formLabel, bool showPassword,
    void Function() displayPassword) {
  return TextFormField(
    obscureText: showPassword,
    decoration: InputDecoration(
        filled: true,
        label: Text(formLabel),
        labelStyle: textTheme.bodySmall,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        fillColor: textFieldBackground,
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: secondary)),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(
            hoverColor: onSecondary,
            highlightColor: onSecondary,
            splashColor: onSecondary,
            style:
                ButtonStyle(fixedSize: WidgetStatePropertyAll(Size(18, 18))),
            onPressed: () => displayPassword(),
            icon: showPassword
                ? Icon(FontAwesomeIcons.eye)
                : Icon(FontAwesomeIcons.eyeSlash),
            iconSize: 18,
          ),
        )),
  );
}
