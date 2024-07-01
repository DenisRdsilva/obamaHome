import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:obamahome/auth/services/authentication_controller.dart';

import '../../utils/app_theme.dart';

class GoogleUser {
  String userName;
  String userEmail;

  GoogleUser({required this.userName, required this.userEmail});
}

class GoogleSigninButton extends ConsumerStatefulWidget {
  const GoogleSigninButton({super.key});

  @override
  _GoogleSigninButtonState createState() => _GoogleSigninButtonState();
}

class _GoogleSigninButtonState extends ConsumerState<GoogleSigninButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 170,
      child: ElevatedButton(
        onPressed: () async {
          ref.read(authControllerProvider.notifier).authenticate();
          // await LoginAPI.login(ref);
          // bool boolLog = await GoogleSignIn().isSignedIn();
          // () => widget.isLogged(boolLog);
          // print(" userData => $user");
          
        },
        style: ButtonStyle(
          side:
              WidgetStatePropertyAll(BorderSide(width: 1, color: secondary)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Google", style: textTheme.headlineSmall),
            SizedBox(width: 5),
            Icon(FontAwesomeIcons.google, color: Colors.red, size: 14)
          ],
        ),
      ),
    );
  }
}
