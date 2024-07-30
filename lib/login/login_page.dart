import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool emailError = false;
  bool passwordError = false;

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
    return Scaffold(
      body: SingleChildScrollView(
        physics:
            const ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.065 +
                                      10),
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
                        text: "Нет аккаунта? ",
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
