import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({
    super.key,
  });

  @override
  State<WelcomePage> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  bool _initEnded = false;

  void _onEnd({String? route, Object? arguments}) {
    if (!_initEnded) {
      _controller.animateTo(0.0).then((_) {
        setState(() {
          _initEnded = true;
        });
        if (route == null) {
          _controller.forward();
        } else {
          Navigator.pushNamed(context, route, arguments: arguments);
        }
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

    _fadeAnimation = _easeInTween.animate(_controller);

    try {
      _controller.repeat(reverse: true);
    } on TickerCanceled {
      print("Animation canceled");
    }

    Future.delayed(const Duration(seconds: 2)).then((_) =>
        _onEnd()); //to implement onAppInit, which could validate user, refresh tokens and etc
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
