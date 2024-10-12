import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/navigation/routes.dart';

import 'package:Helios/common/ui/elements/elements.dart';
import 'package:Helios/features/register_sign_in/widgets/widgets.dart';

import 'package:Helios/repositories/auth_repository/high_level/sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool canPop = true;

  void _handleSignIn() {
    setState(() {
      canPop = false;
    });

    final LoadingIcon loadingIcon = LoadingIcon();

    loadingIcon.showLoadingIcon(context);

    signIn(
      context,
      email: emailController.text,
      password: passwordController.text,
    ).then(
      (response) {
        setState(() {
          canPop = true;
        });

        loadingIcon.removeLoadingIcon();

        if (!mounted) {
          return;
        }
        if (response == Auth.success) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.home,
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar(context, title: response.name));
        }
      },
    );
  }

  @override
  void initState() {
    super.initState;
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(
            parent: NeverScrollableScrollPhysics(),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: HeliosIcon(
                    radius: MediaQuery.of(context).size.width * 0.306,
                    showHelios: true,
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Form(
                      key: _formState,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 60,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 62,
                            ),
                            HeliosFormTextField(
                              controller: emailController,
                              text: "Введите email",
                              textOnError: "Введите существующий email",
                              keyboardType: TextInputType.emailAddress,
                              validityCriteria: (value) =>
                                  EmailValidator.validate(value!),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HeliosFormTextField(
                              controller: passwordController,
                              text: "Введите пароль",
                              textOnError: "Введите пароль",
                              validityCriteria: (value) => (value!.isNotEmpty),
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Забыли пароль?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            HeliosButton(
                              label: "Войти",
                              color: Theme.of(context).colorScheme.onBackground,
                              onTap: () {
                                if (_formState.currentState!.validate()) {
                                  _handleSignIn();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0.0, -32.0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Нет аккаунта? ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.5)),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: InkWell(
                                  child: Text(
                                    "Зарегистрируйтесь!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, RouteNames.reg);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
