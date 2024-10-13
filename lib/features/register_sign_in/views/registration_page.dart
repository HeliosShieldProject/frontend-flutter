import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:password_validator_package/password_validator_package.dart';
import 'package:email_validator/email_validator.dart';

import 'package:Helios/common/constants/constants.dart';
import 'package:Helios/common/enums/enums.dart';

import 'package:Helios/features/register_sign_in/domain/bloc/sign_up_bloc/sign_up_bloc.dart';

import 'package:Helios/common/ui/elements/elements.dart';
import 'package:Helios/common/ui/utils/utils.dart';
import 'package:Helios/features/register_sign_in/widgets/widgets.dart';

import 'package:Helios/common/navigation/routes.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController0;
  late final TextEditingController _passwordController1;

  bool canPop = true;
  late LoadingIcon loadingIcon;

  late Size screenSize;
  late ColorScheme colorScheme;

  @override
  void initState() {
    super.initState;

    _emailController = TextEditingController();
    _passwordController0 = TextEditingController();
    _passwordController1 = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController0.dispose();
    _passwordController1.dispose();

    super.dispose();
  }

  void _onTapSignUp({required SignUpBloc signUpBloc}) {
    if (_formState.currentState?.validate() ?? false) {
      final SignUpExecutedEvent event = SignUpExecutedEvent(
        email: _emailController.value.text,
        password: _passwordController0.value.text,
      );

      signUpBloc.add(event);
    }
  }

  void _blocListener(BuildContext context, SignUpState state) {
    switch (state.signInStatus) {
      case Auth.loading:
        loadingIcon = LoadingIcon();
        loadingIcon.showLoadingIcon(context);
        break;
      case Auth.success:
        loadingIcon.removeLoadingIcon();
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteNames.home,
          (route) => false,
        );
        break;
      case null:
        break;
      default:
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar(
            context,
            title: state.signInStatus!.name,
          ),
        );
    }
  }

  void _underButtonTextCallBack(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      RouteNames.login,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final ThemeData themeData = Theme.of(context);
    colorScheme = themeData.colorScheme;

    screenSize = MediaQuery.sizeOf(context);
  }

  @override
  Widget build(BuildContext context) => BlocListener<SignUpBloc, SignUpState>(
        listener: _blocListener,
        child: PopScope(
          canPop: canPop,
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(
                parent: NeverScrollableScrollPhysics(),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: NumericConstants.horizontalPadding,
                  right: NumericConstants.horizontalPadding,
                  bottom: NumericConstants.bottomPadding,
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: HeliosIcon(
                        radius: Multipliers.screenWidth2IconRadius *
                            screenSize.width,
                        showHelios: true,
                      ),
                    ),
                    RegisterForm(
                      formState: _formState,
                      emailController: _emailController,
                      passwordController0: _passwordController0,
                      passwordController1: _passwordController1,
                    ),
                    blankSpacerV(
                      multiplier: Multipliers.bigGap2BlankSpacer,
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        HeliosButton(
                          label: Literals.toSignIn,
                          color: colorScheme.onSurface,
                          onTap: () => _onTapSignUp(
                            signUpBloc: context.read<SignUpBloc>(),
                          ),
                        ),
                        UnderButtonText(
                          firstText: Literals.haveAccount,
                          secondText: Literals.signIn,
                          onTap: () => _underButtonTextCallBack,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.emailController,
    required this.passwordController0,
    required this.passwordController1,
    required this.formState,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController0;
  final TextEditingController passwordController1;
  final GlobalKey<FormState> formState;

  bool _secondPasswordFieldValidator(String? password) {
    return password == passwordController0.value.text;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
        children: <Widget>[
          HeliosFormTextField(
            controller: emailController,
            text: Literals.emailField,
            textOnError: Literals.emailFieldOnError,
            validityCriteria: (email) => EmailValidator.validate(email ?? ""),
          ),
          blankSpacerV(),
          HeliosFormTextField(
            controller: passwordController0,
            text: Literals.passwordFeild,
            textOnError: Literals.passwordFieldOnError,
            validityCriteria: (password) =>
                PasswordValidator.validatePassword(password ?? ""),
            obscureText: true,
            textInputAction: TextInputAction.next,
          ),
          blankSpacerV(),
          HeliosFormTextField(
            controller: passwordController0,
            text: Literals.passwordFeild,
            textOnError: Literals.passwordFieldOnError,
            validityCriteria: _secondPasswordFieldValidator,
            obscureText: true,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
