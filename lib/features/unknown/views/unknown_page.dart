import 'dart:math';

import 'package:flutter/material.dart';

import 'package:Helios/common/constants/constants.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              NumericConstants.horizontalPadding,
              NumericConstants.horizontalPadding,
              NumericConstants.bottomPadding,
              NumericConstants.topPadding,
            ),
            child: RotatedBox(
              quarterTurns: 1,
              child: Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: "404 ",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 60,
                              ),
                    ),
                    TextSpan(
                      text: "такой страницы пока не сущетвует :)",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UnknownPageBg extends StatefulWidget {
  const UnknownPageBg({super.key});

  @override
  State<UnknownPageBg> createState() => _UnknownPageBgState();
}

class _UnknownPageBgState extends State<UnknownPageBg>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<AlignmentGeometry> _animation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class SinTween<T extends num> extends Tween<Point<T>> {
  SinTween({
    required super.begin,
    required super.end,
  });

  @override
  Point<T> lerp(double t) {
    return super.lerp(t);
  }
}
