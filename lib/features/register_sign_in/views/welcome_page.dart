import 'package:Helios/common/constants/constants.dart';
import 'package:Helios/features/register_sign_in/domain/bloc/welcome/welcome_bloc.dart';
import 'package:flutter/material.dart';

import 'package:Helios/common/navigation/routes.dart';

import 'package:Helios/features/register_sign_in/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({
    super.key,
  });

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animatable<double> _easeInTween;

  late Size screenSize;

  bool _initEnded = false;

  @override
  void initState() {
    super.initState();

    _easeInTween = CurveTween(
      curve: Curves.easeIn,
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );

    _fadeAnimation = _controller.drive(
      _easeInTween,
    );
  }

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.sizeOf(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _blocListener(BuildContext context, WelcomeState state) {
    switch (state.appInitStatus) {
      case null:
        break;
      case AppInitStatus.loading:
        _controller.repeat(
          reverse: true,
        );
        break;
      case AppInitStatus.success:
        _controller.animateTo(0.0).then(
              (_) => Navigator.pushReplacementNamed(
                context,
                RouteNames.home,
              ),
            );
        break;
      case AppInitStatus.failed:
        _controller.animateTo(0.0).then(
              (_) => setState(() {
                _initEnded = true;
                _controller.forward(
                  from: 0.0,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  snackBar(
                    context,
                    title: Literals.failed,
                  ),
                );
              }),
            );
        break;
      case AppInitStatus.userNotSufficient:
        _controller.animateTo(0.0).then(
              (_) => setState(() {
                _initEnded = true;
                _controller.forward(
                  from: 0.0,
                );
              }),
            );
    }
  }

  @override
  Widget build(BuildContext context) => BlocListener<WelcomeBloc, WelcomeState>(
        listener: _blocListener,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Column(
            children: <Widget>[
              Expanded(
                child: FadingHeliosIcon(
                  radius: screenSize.width * Multipliers.screenWidth2IconRadius,
                  showHelios: _initEnded,
                  fadeAnimation: _fadeAnimation,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: NumericConstants.horizontalPadding,
                  right: NumericConstants.horizontalPadding,
                  bottom: NumericConstants.bottomPadding,
                ),
                child: FadingButton(
                  onTap: () => Navigator.pushNamed(
                    context,
                    RouteNames.login,
                  ),
                  label: Literals.toContinue,
                  shouldStartFading: _initEnded,
                  fadeAnimation: _fadeAnimation,
                ),
              ),
            ],
          ),
        ),
      );
}
