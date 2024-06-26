import 'package:flutter/material.dart';

import '../components/mainButton.dart';
import '../templates/template_basic_col.dart';
import 'components/formFields.dart';
import 'components/googleSignInButton.dart';

List<String> passwordFields = ["Senha", "Confirmar senha"];

class SignInPageView extends StatefulWidget {
  const SignInPageView({super.key});

  @override
  State<SignInPageView> createState() => _SignInPageViewState();
}

class _SignInPageViewState extends State<SignInPageView> {
  GlobalKey signInKey = GlobalKey<FormState>();
  bool showPassword = true;

  void displayPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TemplateColumn(children: [
      Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Form(
            key: signInKey,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 350),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 30),
                  child: Image.network("assets/images/icone.png", width: 150),
                ),
                formFieldNoHide(context, "Nome"),
                SizedBox(height: 10),
                formFieldNoHide(context, "E-mail"),
                for (var passwordField in passwordFields) ...{
                  SizedBox(height: 10),
                  formFieldHidden(
                      context, passwordField, showPassword, displayPassword),
                },
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      mainButton(context, "Cadastrar", null, () {}),
                      GoogleSigninButton(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: Text("Já está cadastrado?")),
                ),
              ]),
            )),
      ),
    ]);
  }
}
