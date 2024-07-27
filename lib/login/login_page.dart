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
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, bottom: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          HeliosFormTextField(
                            controller: emailController,
                            hintText: "Введите email",
                            hintTextOnError: "Введите существующий email",
                            validityCriteria: (value) =>
                                EmailValidator.validate(value!),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          HeliosFormTextField(controller: passwordController, hintText: "Введите пароль", hintTextOnError: "Введите пароль", validityCriteria: (value) => (value!.isNotEmpty), obscureText: true,),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Забыли пароль?",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground,),
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
                    offset: Offset(0.0, -35.0),
                    child: Text(
                      "Зарегистрируйтесь!",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground,),
                    ),
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

class HeliosFormTextField extends StatefulWidget {
  const HeliosFormTextField({super.key,
    required this.controller,
    required this.hintText,
    required this.hintTextOnError,
    required this.validityCriteria,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final String hintTextOnError;
  final bool Function(String?) validityCriteria;
  final bool obscureText;

  @override
  State<HeliosFormTextField> createState() => _HeliosFormTextFieldState();
}

class _HeliosFormTextFieldState extends State<HeliosFormTextField> {
  bool error = false;
  bool obscureSymbols = true; ///only if [widget.obscureText] is true

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.065,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: error ? Border.all(color: Colors.red, width: 2) : null,
      ),
      alignment: Alignment.center,
      child: TextFormField(
          obscureText: widget.obscureText ? obscureSymbols : false,
          style: Theme.of(context).textTheme.bodyMedium,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: error ? widget.hintTextOnError : widget.hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            border: InputBorder.none,
            error: null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
          ),
          controller: widget.controller,
          validator: (value) {
            if (!widget.validityCriteria(value)) {
              setState(() {
                error = true;
                widget.controller.clear();
              });
              return "Error";
            }
            if (error) {
              setState(() {
                error = false;
              });
            }
            return null;
          },
          onTap: () {
            if (error) {
              setState(() {
                error = false;
              });
            }
          }),
    );
  }
}
