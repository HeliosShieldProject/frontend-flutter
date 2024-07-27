import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  bool _initEnded = false;

  void _onEnd() {
    if (!_initEnded) {
      _controller.animateTo(0.0).then((_) {
        setState(() {
          _initEnded = true;
        });
        _controller.forward();
      });
    }
  }

  final Animatable<double> _easeInTween = CurveTween(
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = _controller.drive(_easeInTween);

    try {
      _controller.repeat(reverse: true);
    } on TickerCanceled {
      print("Animation canceled");
    }
  }

  @override
  void didChangeDependencies() {
    final bool isBoxOpen = AppUserSettings.isBoxOpen(context, listen: true) &&
        AppUser.isBoxOpen(context, listen: true);
    if (isBoxOpen) {
      AppUser.of(context)!.isValid() == UserValidity.isValid
          ? Navigator.pushNamed(context, RouteNames.home)
          : Future.delayed(const Duration(seconds: 2)).then((_) => _onEnd());
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).themeData.colorScheme.background,
      body: Column(
        children: <Widget>[
          Expanded(
            child: FadingHeliosIcon(
              radius: MediaQuery.of(context).size.width * 0.306,
              showHelios: _initEnded,
              fadeAnimation: _fadeAnimation,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
            child: FadingButton(
                onTap: () => Navigator.pushNamed(context, RouteNames.login),
                label: "Продолжить",
                shouldStartFading: _initEnded,
                fadeAnimation: _fadeAnimation),
          ),
        ],
      ),
    );
  }
}

class FadingButton extends StatelessWidget {
  const FadingButton({
    super.key,
    required this.onTap,
    this.label,
    required bool shouldStartFading,
    required Animation<double> fadeAnimation,
  })  : _shouldStartFading = shouldStartFading,
        _fadeAnimation = fadeAnimation;

  final bool _shouldStartFading;
  final Animation<double> _fadeAnimation;
  final String? label;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _shouldStartFading
        ? FadeTransition(
            opacity: _fadeAnimation,
            child: HeliosButton(
              onTap: onTap,
              label: label,
              color: AppTheme.of(context).themeData.colorScheme.onBackground,
            ),
          )
        : Container(
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
          );
  }
}
