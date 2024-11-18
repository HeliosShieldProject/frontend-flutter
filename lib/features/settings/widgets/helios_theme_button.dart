import 'package:Helios/common/constants/literals.dart';
import 'package:Helios/common/constants/numeric_constants.dart';
import 'package:flutter/material.dart';

import 'package:Helios/common/enums/enums.dart';

class HeliosThemeButton extends StatefulWidget {
  const HeliosThemeButton({
    super.key,
    required this.theme,
    required this.currentTheme,
    required this.onTap,
  });

  final SelectedTheme theme;
  final SelectedTheme currentTheme;

  final void Function(SelectedTheme) onTap;

  @override
  State<HeliosThemeButton> createState() => _HeliosThemePickerState();
}

class _HeliosThemePickerState extends State<HeliosThemeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final Animatable<double> curveTween = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).chain(
    CurveTween(curve: Curves.easeIn),
  );

  late ThemeData theme;
  late ColorScheme colorScheme;
  late TextTheme textTheme;

  double get effectiveOpacity =>
      widget.theme == widget.currentTheme ? 1.0 : 0.5;

  String get effectiveText => switch (widget.theme) {
        (SelectedTheme.dark) => Literals.dark,
        (SelectedTheme.light) => Literals.light,
        (SelectedTheme.system) => Literals.system,
      };

  IconData get effectiveIcon => switch (widget.theme) {
        (SelectedTheme.dark) => Icons.dark_mode,
        (SelectedTheme.light) => Icons.light_mode,
        (SelectedTheme.system) => Icons.sunny_snowing,
      };

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = curveTween.animate(_controller);

    if (widget.theme == widget.currentTheme) {
      _controller.value = _controller.upperBound;
    }
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);

    colorScheme = theme.colorScheme;
    textTheme = theme.textTheme;

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HeliosThemeButton oldWidget) {
    if (oldWidget.theme == oldWidget.currentTheme &&
        widget.theme != widget.currentTheme) {
      _controller.animateTo(_controller.lowerBound);
    } else if (oldWidget.theme != oldWidget.currentTheme &&
        widget.theme == widget.currentTheme) {
      _controller.animateTo(_controller.upperBound);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        FadeTransition(
          opacity: _animation,
          child: Icon(
            effectiveIcon,
            color: Colors.white,
            size: NumericConstants.iconSize,
          ),
        ),
        AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => widget.onTap(widget.theme),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: _animation.value *
                            (NumericConstants.iconSize +
                                NumericConstants.spacerSize),
                      ),
                      Text(
                        effectiveText,
                        style: textTheme.titleMedium!.copyWith(
                          color: Colors.white.withOpacity(effectiveOpacity),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
