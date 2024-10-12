import 'package:Helios/common/constants/multipliers.dart';
import 'package:Helios/common/ui/utils/blank_spacer.dart';
import 'package:Helios/features/register_sign_in/domain/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';

import 'package:Helios/common/navigation/routes.dart';

import 'package:Helios/common/ui/elements/elements.dart';
import 'package:Helios/features/register_sign_in/widgets/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_validator_package/password_validator_package.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController _passwordController;

  bool canPop = true;

  late Size screenSize;
  late TextTheme textTheme;

  @override
  void initState() {
    super.initState;

    emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    screenSize = MediaQuery.sizeOf(context);
    textTheme = Theme.of(context).textTheme;
  }

  @override
  Widget build(BuildContext context) => BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (!canPop) {}
        },
        child: PopScope(
          canPop: canPop,
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(
                parent: NeverScrollableScrollPhysics(),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: HeliosIcon(
                      radius:
                          Multipliers.iconRadiusMultiplier * screenSize.width,
                      showHelios: true,
                    ),
                  ),
                  blankSpacer(multiplier: Multipliers.element2BlankSpacer + 1),
                  LoginForm(
                    formState: _formState,
                    emailController: emailController,
                    passwordController: _passwordController,
                  ),
                  blankSpacer(),
                  GestureDetector(
                    child: Text(
                      "Забыли пароль?",
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formState,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formState;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
        children: <Widget>[
          HeliosFormTextField(
            controller: emailController,
            text: "Введите email",
            textOnError: "Введите существующий email",
            validityCriteria: (email) => EmailValidator.validate(email ?? ""),
          ),
          blankSpacer(),
          HeliosFormTextField(
            controller: passwordController,
            text: "Введите пароль",
            textOnError: "Введите корректный пароль",
            validityCriteria: (password) =>
                PasswordValidator.validatePassword(password ?? ""),
          ),
        ],
      ),
    );
  }
}
