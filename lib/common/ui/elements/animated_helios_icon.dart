import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helios/app/ui/app.dart';
import '../../common.dart';

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
    super.didChangeDependencies();
    final bool isBoxOpen = AppUserSettings.isBoxOpen(context, listen: true) &&
      AppUser.isBoxOpen(context, listen: true);
    if (isBoxOpen) {
      AppUser.of(context)!.isValid() == UserValidity.isValid
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()))
          : Future.delayed(const Duration(seconds: 7)).then((_) => _onEnd());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).themeData.colorScheme.background,
      body: Column(
        children: <Widget>[
          Expanded(
            child: FadingHeliosIcon(
              showHelios: _initEnded,
              fadeAnimation: _fadeAnimation,
              size: Size.fromRadius(MediaQuery.of(context).size.width * 0.305),
            ),
          ),
          FadingButton(
            shouldStartFading: _initEnded, 
            fadeAnimation: _fadeAnimation
          )
        ],
      ),
    );
  }
}

class FadingButton extends StatefulWidget {
  const FadingButton({
    super.key,
    required bool shouldStartFading,
    required Animation<double> fadeAnimation,
  }) : _initEnded = shouldStartFading, _fadeAnimation = fadeAnimation;

  final bool _initEnded;
  final Animation<double> _fadeAnimation;

  @override
  State<FadingButton> createState() => _FadingButtonState();
}

class _FadingButtonState extends State<FadingButton> {
  bool isPressed = false; 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
          child: widget._initEnded
              ? FadeTransition(
                  opacity: widget._fadeAnimation,
                  child: GestureDetector(
                    onTapDown: (details) => setState(() {
                      isPressed = true;
                    },),
                    onTapUp: (details) => Timer(const Duration(seconds: 1), () => setState(() {
                          isPressed = false;
                        }
                      )
                    ),
                    onTapCancel: () => setState(() {
                      isPressed = false;
                    },),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const HomeScreen())
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.065,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context)
                            .themeData
                            .colorScheme
                            .onBackground
                            .withOpacity(isPressed ? 0.5 : 1.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Продолжить",
                      ),
                    ),
                  ),
                )
              : Container(
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                )),
    );
  }
}

class FadingHeliosIcon extends StatelessWidget {
  const FadingHeliosIcon({
    super.key,
    required Animation<double> fadeAnimation,
    required this.size,
    required bool showHelios,
  })  : _fadeAnimation = fadeAnimation,
        _showHelios = showHelios;

  final Animation<double> _fadeAnimation;
  final Size size;
  final bool _showHelios;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(-0.7, 0),
                    end: const Alignment(0.3, 0.3),
                    colors: <Color>[
                      AppTheme.of(context).themeData.colorScheme.primary,
                      AppTheme.of(context).themeData.colorScheme.secondary,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 35.0, sigmaY: 35.0),
            child: Container(),
          ),
          Center(
            child: _showHelios
                ? FadeTransition(
                    opacity: _fadeAnimation,
                    child: SvgPicture.asset(
                      "assets/helios_icon.svg",
                      width: size.width * 0.5,
                    ),
                  )
                : null,
          )
        ],
      ),
    );
  }
}
