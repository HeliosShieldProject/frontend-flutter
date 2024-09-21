import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/navigation/routes.dart';

import 'package:Helios/common/ui/elements/elements.dart';
import 'package:Helios/features/register_sign_in/widgets/widgets.dart';

import 'package:Helios/features/register_sign_in/domain/server/high_level/sign_up.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController1;
  late final TextEditingController passwordController2;
  bool canPop = true;

  void _handleSignUp() {
    setState(() {
      canPop = false;
    });

    final LoadingIcon loadingIcon = LoadingIcon();

    loadingIcon.showLoadingIcon(context);

    signUp(
      context,
      email: emailController.text,
      password: passwordController1.text,
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
    passwordController1 = TextEditingController();
    passwordController2 = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController1.dispose();
    passwordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(
              parent: NeverScrollableScrollPhysics()),
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
                              controller: passwordController1,
                              text: "Введите пароль",
                              textOnError: "Введите пароль",
                              validityCriteria: (value) => (value!.isNotEmpty),
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HeliosFormTextField(
                              controller: passwordController2,
                              text: "Повторите пароль",
                              textOnError: "Пароли не совпадают",
                              validityCriteria: (value) => (value!.isNotEmpty &&
                                  value == passwordController1.text),
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "",
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
                              label: "Зарегистрироваться",
                              color: Theme.of(context).colorScheme.onBackground,
                              onTap: () {
                                if (_formState.currentState!.validate()) {
                                  _handleSignUp();
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
                              text: "Есть аккаунт? ",
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
                                    "Войдите!",
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
                                        context, RouteNames.login);
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
