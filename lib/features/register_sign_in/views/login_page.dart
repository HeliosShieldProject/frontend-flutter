import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:password_validator_package/password_validator_package.dart';
import 'package:email_validator/email_validator.dart';

import 'package:Helios/common/constants/constants.dart';
import 'package:Helios/common/enums/enums.dart';

import 'package:Helios/features/register_sign_in/domain/bloc/sign_in_bloc/sign_in_bloc.dart';

import 'package:Helios/common/ui/elements/elements.dart';
import 'package:Helios/common/ui/utils/utils.dart';
import 'package:Helios/features/register_sign_in/widgets/widgets.dart';

import 'package:Helios/features/register_sign_in/domain/utils/text_size.dart';

import 'package:Helios/common/navigation/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool canPop = true;
  late LoadingIcon loadingIcon;

  late Size screenSize;
  late TextTheme textTheme;
  late ColorScheme colorScheme;

  @override
  void initState() {
    super.initState;

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _onTapSignIn({required SignInBloc signInBloc}) {
    if (_formState.currentState?.validate() ?? false) {
      final SignInExecutedEvent event = SignInExecutedEvent(
        email: _emailController.value.text,
        password: _passwordController.value.text,
      );

      signInBloc.add(event);
    }
  }

  void _blocListener(BuildContext context, SignInState state) {
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

  void _underFieldTextCallBack(BuildContext context) {}

  void _underButtonTextCallBack(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      RouteNames.reg,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final ThemeData themeData = Theme.of(context);
    textTheme = themeData.textTheme;
    colorScheme = themeData.colorScheme;

    screenSize = MediaQuery.sizeOf(context);
  }

  @override
  Widget build(BuildContext context) => BlocListener<SignInBloc, SignInState>(
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
                    blankSpacerV(
                      multiplier: Multipliers.element2BlankSpacer + 1,
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        LoginForm(
                          formState: _formState,
                          emailController: _emailController,
                          passwordController: _passwordController,
                        ),
                        Transform.translate(
                          offset: Offset.fromDirection(
                            NumericConstants.pi / 2,
                            NumericConstants.spacerSize +
                                textSize(
                                  Literals.forgotPassword,
                                  textTheme.labelMedium!,
                                ).height,
                          ),
                          child: GestureDetector(
                            child: Text(
                              Literals.forgotPassword,
                              style: textTheme.labelMedium,
                            ),
                            onTap: () => _underFieldTextCallBack,
                          ),
                        ),
                      ],
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
                          onTap: () => _onTapSignIn(
                            signInBloc: context.read<SignInBloc>(),
                          ),
                        ),
                        UnderButtonText(
                          firstText: Literals.noAccount,
                          secondText: Literals.signUp,
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

class UnderButtonText extends StatelessWidget {
  const UnderButtonText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onTap,
  });

  final String firstText;
  final String secondText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    final ColorScheme colorScheme = themeData.colorScheme;
    final TextTheme textTheme = themeData.textTheme;

    return Transform.translate(
      offset: Offset.fromDirection(
        NumericConstants.pi / 2,
        NumericConstants.spacerSize +
            textSize(
              "$firstText $secondText",
              textTheme.labelMedium!,
            ).height,
      ),
      child: Text.rich(
        TextSpan(
          children: <InlineSpan>[
            TextSpan(
              text: "$firstText ",
              style: textTheme.labelMedium!.copyWith(
                color: colorScheme.onSurface.withOpacity(
                  0.5,
                ),
              ),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: onTap,
                child: Text(
                  secondText,
                  style: textTheme.labelMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
            text: Literals.emailField,
            textOnError: Literals.emailFieldOnError,
            validityCriteria: (email) => EmailValidator.validate(email ?? ""),
          ),
          blankSpacerV(),
          HeliosFormTextField(
            controller: passwordController,
            text: Literals.passwordFeild,
            textOnError: Literals.passwordFieldOnError,
            validityCriteria: (password) =>
                PasswordValidator.validatePassword(password ?? ""),
            obscureText: true,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
