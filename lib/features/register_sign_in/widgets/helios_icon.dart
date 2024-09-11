import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Creates blurred gradient circle with a Helios logo
/// if specified
///
/// [radius] won't be larger than 150 logical pixels
/// no matter what is passed to it
///
/// [showHelios] determines whether to show the Helios Icon over the
/// gradient circle
class HeliosIcon extends StatelessWidget {
  HeliosIcon({
    super.key,
    required double radius,
    required this.showHelios,
  }) : size = Size.fromRadius(radius);

  final Size size;
  final bool showHelios;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: size.width < 300 ? size.width : 300,
              height: size.width < 300 ? size.width : 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(-0.7, 0),
                  end: const Alignment(0.3, 0.3),
                  colors: <Color>[
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 35.0, sigmaY: 35.0),
            child: Container(),
          ),
          Center(
            child: showHelios
                ? SvgPicture.asset(
                    "assets/helios_icon.svg",
                    width: (size.width < 300 ? size.width : 300) * 0.5,
                  )
                : null,
          )
        ],
      ),
    );
  }
}

/// The Helios Logo, that will be fading according to the [fadeAnimation]
///
/// [radius] won't be larger than 150 logical pixels
/// no matter what is passed to it
///
/// [showHelios] determines whether to show the Helios Icon over the
/// gradient circle
class FadingHeliosIcon extends HeliosIcon {
  FadingHeliosIcon({
    super.key,
    required super.radius,
    required super.showHelios,
    required this.fadeAnimation,
  });

  final Animation<double> fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Container(
                width: size.width < 300 ? size.width : 300,
                height: size.width < 300 ? size.width : 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(-0.7, 0),
                    end: const Alignment(0.3, 0.3),
                    colors: <Color>[
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
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
            child: showHelios
                ? FadeTransition(
                    opacity: fadeAnimation,
                    child: SvgPicture.asset(
                      "assets/helios_icon.svg",
                      width: (size.width < 300 ? size.width : 300) * 0.5,
                    ),
                  )
                : null,
          )
        ],
      ),
    );
  }
}
