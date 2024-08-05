import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';

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
    return Scaffold(
      body: SingleChildScrollView(
        physics:
            const ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
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
                          left: 20, right: 20, bottom: 60),
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
                            clearOnError: false,
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
                                Navigator.pushNamed(context, RouteNames.home);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0, -32.0),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                        text: "Есть аккаунт? ",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                    ])),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
