import 'package:flutter/gestures.dart';
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

  late final TapGestureRecognizer _underFieldTextRecognizer;
  late final TapGestureRecognizer _underButtonTextRecognizer;

  bool canPop = true;
  late LoadingIcon loadingIcon;

  late Size screenSize;
  late TextTheme textTheme;
  late ColorScheme colorScheme;

  double get _bottomPadding2BlankSpacer =>
      NumericConstants.bottomPadding / NumericConstants.spacerSize;

  @override
  void initState() {
    super.initState;

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _underFieldTextRecognizer = TapGestureRecognizer();
    _underFieldTextRecognizer.onTap = () => _underFieldTextCallBack(context);

    _underButtonTextRecognizer = TapGestureRecognizer();
    _underButtonTextRecognizer.onTap = () => _underButtonTextCallBack(context);
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _underFieldTextRecognizer.dispose();
    _underButtonTextRecognizer.dispose();

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
      case null:
        break;
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
      default:
        loadingIcon.removeLoadingIcon();
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
  Widget build(BuildContext context) => BlocListener<SignInBloc, SignInState>(
        listener: _blocListener,
        child: PopScope(
          canPop: canPop,
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(
                parent: NeverScrollableScrollPhysics(),
              ),
              child: SizedBox(
                height: screenSize.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: NumericConstants.horizontalPadding,
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
                      const BlankSpacer(
                        multiplier: Multipliers.element2BlankSpacer + 1,
                      ),
                      LoginForm(
                        formState: _formState,
                        emailController: _emailController,
                        passwordController: _passwordController,
                      ),
                      BlankSpacer(
                        multiplier: Multipliers.bigGap2BlankSpacer,
                        child: Text.rich(
                          TextSpan(
                            recognizer: _underFieldTextRecognizer,
                            text: Literals.forgotPassword,
                            style: textTheme.labelMedium,
                          ),
                        ),
                      ),
                      HeliosButton(
                        label: Literals.toSignIn,
                        color: colorScheme.onSurface,
                        onTap: () => _onTapSignIn(
                          signInBloc: context.read<SignInBloc>(),
                        ),
                      ),
                      BlankSpacer(
                        multiplier: _bottomPadding2BlankSpacer,
                        child: Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text: "${Literals.noAccount} ",
                                style: textTheme.labelMedium!.copyWith(
                                  color: colorScheme.onSurface.withOpacity(0.5),
                                ),
                              ),
                              TextSpan(
                                recognizer: _underButtonTextRecognizer,
                                text: Literals.signUp,
                                style: textTheme.labelMedium,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
            text: Literals.emailField,
            textOnError: Literals.emailFieldOnError,
            validityCriteria: (email) => EmailValidator.validate(email ?? ""),
          ),
          const BlankSpacer(),
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
