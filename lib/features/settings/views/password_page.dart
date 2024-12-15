import 'package:Helios/common/constants/constants.dart';
import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/ui/elements/custom_dialog.dart';
import 'package:Helios/common/ui/elements/elements.dart';
import 'package:Helios/common/ui/utils/blank_spacer.dart';
import 'package:Helios/features/register_sign_in/widgets/loading_icon.dart';
import 'package:Helios/features/register_sign_in/widgets/snackbar.dart';
import 'package:Helios/features/settings/domain/bloc/password_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_validator_package/password_validator_package.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  late final TextEditingController _previousPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _newPasswordController1;

  late ColorScheme colorScheme;
  late TextTheme textTheme;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool canPop = true;
  LoadingIcon? loadingIcon;

  @override
  void initState() {
    super.initState();

    _previousPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _newPasswordController1 = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final ThemeData theme = Theme.of(context);

    colorScheme = theme.colorScheme;
    textTheme = theme.textTheme;
  }

  @override
  void dispose() {
    _previousPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordController1.dispose();

    super.dispose();
  }

  void _onTapAppBar(BuildContext context) => Navigator.maybePop(context);

  void _handleChangePassword({required PasswordBloc bloc}) {
    if (formKey.currentState?.validate() ?? false) {
      bloc.add(
        PasswordChangeExecutedEvent(newPassword: _newPasswordController.text),
      );
    }
  }

  void _passwordBlocListener(BuildContext context, PasswordState state) {
    switch (state.status) {
      case null:
        _handleCanPop();
        loadingIcon?.removeLoadingIcon();
        break;
      case Auth.loading:
        setState(() {
          canPop = false;
          loadingIcon = LoadingIcon()..showLoadingIcon(context);
        });
        break;
      case Auth.success:
        _handleCanPop();
        loadingIcon?.removeLoadingIcon();
        _previousPasswordController.clear();
        _newPasswordController.clear();
        _newPasswordController1.clear();
        showDialog(
          context: context,
          builder: (context) => const CustomDialog(
            buttonLabel: Literals.toContinue,
            dialogTitle: Literals.changedPasswordSuccessfully,
          ),
        );
        break;
      default:
        _handleCanPop();
        loadingIcon?.removeLoadingIcon();
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar(context, title: state.status!.name),
        );
    }
  }

  void _handleCanPop() {
    if (!canPop) {
      setState(() {
        canPop = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: canPop,
        child: BlocListener<PasswordBloc, PasswordState>(
          listener: _passwordBlocListener,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: NumericConstants.iconSize,
                  color: colorScheme.onSurface,
                ),
                onPressed: () => _onTapAppBar(context),
              ),
              title: Text(
                Literals.password,
                style: textTheme.titleLarge,
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: NumericConstants.topPadding,
                  left: NumericConstants.horizontalPadding,
                  right: NumericConstants.horizontalPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SingleChildScrollView(
                      physics: const ClampingScrollPhysics(
                          parent: NeverScrollableScrollPhysics()),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              Literals.previousPassword,
                              style: textTheme.titleLarge,
                            ),
                            const BlankSpacer(
                              multiplier: 1.5,
                            ),
                            HeliosFormTextField(
                              controller: _previousPasswordController,
                              obscureText: true,
                              text: Literals.enterPreviousPassword,
                              textOnError: Literals.enterPreviousPassword,
                              validityCriteria: (value) =>
                                  value?.isNotEmpty ?? false,
                            ),
                            const BlankSpacer(
                              multiplier: 4,
                            ),
                            Text(
                              Literals.newPassword,
                              style: textTheme.titleLarge,
                            ),
                            const BlankSpacer(
                              multiplier: 1.5,
                            ),
                            HeliosFormTextField(
                              controller: _newPasswordController,
                              obscureText: true,
                              text: Literals.enterNewPassword,
                              textOnError: Literals.enterNewPasswordOnError,
                              validityCriteria: (password) =>
                                  PasswordValidator.validatePassword(
                                      password ?? ""),
                            ),
                            const BlankSpacer(),
                            HeliosFormTextField(
                              controller: _newPasswordController1,
                              obscureText: true,
                              text: Literals.repeatNewPassword,
                              textOnError: Literals.repeatNewPasswordOnError,
                              validityCriteria: (value) =>
                                  value == _newPasswordController.text &&
                                  _newPasswordController1.text.isNotEmpty,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        HeliosButton(
                          label: Literals.toSubmit,
                          color: colorScheme.onSurface,
                          onTap: () => _handleChangePassword(
                            bloc: context.read<PasswordBloc>(),
                          ),
                        ),
                        BlankSpacer(
                          multiplier: Multipliers.authBottomPadding2BlankSpacer,
                          child: Text(
                            Literals.passwordTestimonial,
                            style: textTheme.bodyMedium!.copyWith(
                              color:
                                  colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
