import 'package:Helios/common/user_settings/user_settings_provider.dart';
import 'package:flutter/material.dart';

import 'package:Helios/common/enums/enums.dart';

class HeliosThemeButton extends StatefulWidget {
  const HeliosThemeButton({super.key, required this.theme});

  final SelectedTheme theme;

  @override
  State<HeliosThemeButton> createState() => _HeliosThemePickerState();
}

class _HeliosThemePickerState extends State<HeliosThemeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool selected = false;

  Color get effectiveColor {
    return selected ? Colors.white : Colors.white.withOpacity(0.5);
  }

  String get effectiveText {
    return switch (widget.theme) {
      (SelectedTheme.dark) => "Тёмная",
      (SelectedTheme.light) => "Светлая",
      (SelectedTheme.system) => "Системная",
    };
  }

  IconData get effectiveIcon {
    return switch (widget.theme) {
      (SelectedTheme.dark) => Icons.dark_mode,
      (SelectedTheme.light) => Icons.light_mode,
      (SelectedTheme.system) => Icons.sunny_snowing,
    };
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    _animation = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_controller);

    if (widget.theme == AppUserSettings.of(context).selectedTheme) {
      selected = true;
      _controller.value = 1.0;
    }
  }

  @override
  void didChangeDependencies() {
    final SelectedTheme selectedTheme =
        AppUserSettings.of(context, listen: true).selectedTheme!;

    if (selectedTheme == widget.theme && !selected) {
      setState(() {
        selected = true;
      });
      _controller.forward();
    } else if (selectedTheme != widget.theme && selected) {
      setState(() {
        selected = false;
      });
      _controller.reverse();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        FadeTransition(
          opacity: _animation,
          child: Icon(effectiveIcon, color: effectiveColor, size: 20),
        ),
        AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () =>
                      AppUserSettings.changeTheme(context, widget.theme),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: _animation.value * 30,
                      ),
                      Text(
                        effectiveText,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: effectiveColor,
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
