import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:Helios/common/constants/constants.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
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
            const UnknownPageBg(),
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
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
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

class UnknownPageBg extends StatefulWidget {
  const UnknownPageBg({super.key});

  @override
  State<UnknownPageBg> createState() => _UnknownPageBgState();
}

class _UnknownPageBgState extends State<UnknownPageBg>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final AnimationController _animationController1;
  late final Animation<Point<double>> _animation;
  late final Animation<Point<double>> _animation1;

  late final BezierTween _bezierTween;
  late final BezierTween _bezierTween1;

  @override
  void initState() {
    super.initState();

    _bezierTween = BezierTween(
      begin: const Point(-1.0, -1.0),
      end: const Point(1.0, 1.0),
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );

    _animation = _bezierTween.animate(_animationController);

    _animationController.repeat(reverse: true);

    _bezierTween1 = BezierTween(
      begin: const Point(-.7, -1.0),
      end: const Point(.7, 1.0),
    );

    _animationController1 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );

    _animation1 = _bezierTween1.animate(_animationController1);

    _animationController1.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController1.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animation1,
          builder: (context, child) => Align(
            alignment: Alignment(_animation1.value.x, _animation1.value.y),
            child: Container(
              width: 300,
              height: 300,
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
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Align(
            alignment: Alignment(_animation.value.x, _animation.value.y),
            child: Container(
              width: 200,
              height: 200,
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
          filter: ImageFilter.blur(
            sigmaX: screenSize.width / 10,
            sigmaY: screenSize.height / 10,
          ),
          child: Container(),
        ),
      ],
    );
  }
}

class BezierTween extends Tween<Point<double>> {
  BezierTween({
    required super.begin,
    required super.end,
  });

  @override
  Point<double> lerp(double t) {
    final Point<double> p0 = begin!;
    final Point<double> p3 = end!;
    final Point<double> p1 = Point(p3.x / 3, p0.y / 3);
    final Point<double> p2 = Point((p3.x * 2) / 3, (p0.y * 2) / 3);

    final double x = pow(1.0 - t, 3.0) * p0.x +
        3.0 * pow(1 - t, 2.0) * t * p1.x +
        3.0 * (1 - t) * pow(t, 2.0) * p2.x +
        pow(t, 3.0) * p3.x;
    final double y = pow(1.0 - t, 3.0) * p0.y +
        3.0 * pow(1 - t, 2.0) * t * p1.y +
        3.0 * (1 - t) * pow(t, 2.0) * p2.y +
        pow(t, 3.0) * p3.y;

    final Point<double> result = Point(x, y);

    return result;
  }

  @override
  Point<double> transform(double t) {
    return lerp(t);
  }
}
