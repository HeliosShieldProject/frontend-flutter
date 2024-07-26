import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../common.dart';

class HeliosIcon extends StatelessWidget {
  const HeliosIcon({
    super.key,
    required this.size, //can't be larger than 300 logical pixels in width and heigth.
    required this.showHelios,
  });

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
                    AppTheme.of(context).themeData.colorScheme.primary,
                    AppTheme.of(context).themeData.colorScheme.secondary,
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

class FadingHeliosIcon extends HeliosIcon {
  const FadingHeliosIcon({
    super.key,
    required super.size, //can't be larger than 300 logical pixels in width and heigth.
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
