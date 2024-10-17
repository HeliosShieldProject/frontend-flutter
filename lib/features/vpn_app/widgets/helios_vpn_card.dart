import 'package:flutter/material.dart';

import 'dart:math';

import 'package:Helios/common/constants/constants.dart';

import 'package:Helios/common/interafces/country.dart';
import 'package:country_flags/country_flags.dart';

import 'package:Helios/common/ui/utils/blank_spacer.dart';

import 'package:Helios/features/register_sign_in/domain/utils/text_size.dart';

class HeliosVpnCard extends StatefulWidget {
  const HeliosVpnCard({
    super.key,
    required this.connected,
    this.currentCountry,
    this.uploadSpeed,
    this.downloadSpeed,
  });

  final bool connected;
  final double? uploadSpeed;
  final double? downloadSpeed;
  final Country? currentCountry;

  @override
  State<HeliosVpnCard> createState() => _HeliosVpnCardState();
}

class _HeliosVpnCardState extends State<HeliosVpnCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _gradientAnimationController;
  late Animation<Gradient> _gradientAnimation;

  late final ColorScheme colorScheme;
  late final TextTheme textTheme;

  Size get _downloadUploadTextSize => textSize(
        "00.0",
        textTheme.titleMedium!,
      );

  Size get _countryTextSize => textSize(
        "Russia",
        textTheme.titleLarge!,
      );

  Size get _countryIpTextSize => textSize(
        "15.167.23.190",
        textTheme.bodyMedium!,
      );

  Widget get _effectiveCountryIcon {
    return widget.currentCountry == null
        ? AnimatedBuilder(
            animation: _gradientAnimation,
            builder: (context, _) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: _gradientAnimation.value,
              ),
              height: NumericConstants.cardCountryIconSize,
              width: NumericConstants.cardCountryIconSize,
            ),
          )
        : CountryFlag.fromCountryCode(
            widget.currentCountry!.countryCode,
            shape: const Circle(),
            height: NumericConstants.cardCountryIconSize,
            width: NumericConstants.cardCountryIconSize,
          );
  }

  Widget get _effectiveCountryName {
    final Size textSize = _countryTextSize;

    return widget.currentCountry == null
        ? AnimatedBuilder(
            animation: _gradientAnimation,
            builder: (context, _) => Container(
              width: textSize.width,
              height: textSize.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: _gradientAnimation.value,
              ),
            ),
          )
        : Text(
            widget.currentCountry!.countryName,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Colors.white),
          );
  }

  Widget get effectiveCountryIp {
    final Size textSize = _countryIpTextSize;

    return AnimatedBuilder(
      animation: _gradientAnimation,
      builder: (context, _) => Container(
        width: textSize.width,
        height: textSize.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: _gradientAnimation.value,
        ),
      ),
    );
  }

  Widget get effectiveDownloadText {
    final Size textSize = _downloadUploadTextSize;

    return widget.downloadSpeed == null
        ? Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: AnimatedBuilder(
                    animation: _gradientAnimation,
                    builder: (context, _) => Container(
                      width: textSize.width,
                      height: textSize.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: _gradientAnimation.value,
                      ),
                    ),
                  ),
                ),
                TextSpan(
                  text: " ${Literals.mbs}",
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          )
        : Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.downloadSpeed!.toString(),
                  style: textTheme.titleMedium,
                ),
                TextSpan(
                  text: " ${Literals.mbs}",
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          );
  }

  Widget get effectiveUploadText {
    final Size textSize = _downloadUploadTextSize;

    return widget.uploadSpeed == null
        ? Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: AnimatedBuilder(
                    animation: _gradientAnimation,
                    builder: (context, _) => Container(
                      width: textSize.width,
                      height: textSize.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: _gradientAnimation.value,
                      ),
                    ),
                  ),
                ),
                TextSpan(
                  text: " ${Literals.mbs}",
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          )
        : Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.uploadSpeed!.toString(),
                  style: textTheme.titleMedium,
                ),
                TextSpan(
                  text: " ${Literals.mbs}",
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          );
  }

  @override
  void initState() {
    super.initState();

    _gradientAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _gradientAnimation = GradientTween()
        .chain(CurveTween(curve: Curves.ease))
        .animate(_gradientAnimationController);

    if (widget.downloadSpeed == null ||
        widget.uploadSpeed == null ||
        widget.currentCountry == null) _gradientAnimationController.repeat();
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);

    colorScheme = theme.colorScheme;
    textTheme = theme.textTheme;

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HeliosVpnCard oldWidget) {
    if ((widget.downloadSpeed == null ||
            widget.uploadSpeed == null ||
            widget.currentCountry == null) &&
        _gradientAnimationController.status != AnimationStatus.forward) {
      _gradientAnimationController.repeat();
      setState(() {});
    } else if (!(widget.downloadSpeed == null ||
            widget.uploadSpeed == null ||
            widget.currentCountry == null) &&
        _gradientAnimationController.status == AnimationStatus.forward) {
      _gradientAnimationController.stop();
      setState(() {});
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _gradientAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          NumericConstants.borderRadius,
        ),
        color: colorScheme.tertiary,
      ),
      height: NumericConstants.cardHeight,
      child: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(
              height: NumericConstants.cardHeight / 2,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: NumericConstants.horizontalPadding,
                vertical: NumericConstants.cardVerticalPadding,
              ),
              child: Row(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(
                          width: NumericConstants.cardCountryIconTrimSize,
                          height: NumericConstants.cardCountryIconTrimSize,
                        ),
                        child: CustomPaint(
                          painter: CustomTrim(
                            colors: widget.connected
                                ? <Color>[
                                    colorScheme.secondary,
                                    colorScheme.primary
                                  ]
                                : null,
                          ),
                        ),
                      ),
                      _effectiveCountryIcon,
                    ],
                  ),
                  const BlankSpacer(
                    horizontal: true,
                    multiplier: 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: _effectiveCountryName,
                      ),
                      const BlankSpacer(
                        multiplier: 0.5,
                      ),
                      Expanded(
                        child: effectiveCountryIp,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: NumericConstants.horizontalPadding,
            ),
            child: Divider(
              thickness: 2,
              height: 0,
              color: colorScheme.onTertiary,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(
              height: NumericConstants.cardHeight / 2,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: NumericConstants.horizontalPadding + 5,
                vertical: NumericConstants.cardVerticalPadding,
              ),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.arrow_downward_rounded,
                    size: NumericConstants.cardIconSize,
                    color: Colors.white,
                  ),
                  const BlankSpacer(
                    horizontal: true,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      effectiveDownloadText,
                      Text(
                        Literals.dowload,
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  const Icon(
                    Icons.arrow_upward_rounded,
                    size: NumericConstants.cardIconSize,
                    color: Colors.white,
                  ),
                  const BlankSpacer(
                    horizontal: true,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      effectiveUploadText,
                      Text(
                        Literals.upload,
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GradientTween extends Tween<Gradient> {
  @override
  Gradient lerp(double t) {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        Colors.white.withOpacity(0.1),
        Colors.white.withOpacity(
          0.1 + 0.1 * (-pow(t * 2 - 1, 2).toDouble() + 1),
        ),
        Colors.white.withOpacity(0.1),
      ],
      stops: <double>[0.0, t, 1.0],
      tileMode: TileMode.clamp,
    );
  }

  @override
  Gradient transform(double t) {
    return lerp(t);
  }
}

class CustomTrim extends CustomPainter {
  const CustomTrim({
    this.colors,
  });

  final List<Color>? colors;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white
      ..shader = (colors != null)
          ? LinearGradient(
              colors: colors!,
              begin: const Alignment(-0.5, -0.5),
              end: Alignment.bottomRight,
            ).createShader(
              Rect.fromCenter(
                center: Offset(size.width / 2, size.height / 2),
                width: size.width,
                height: size.height,
              ),
            )
          : null;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomTrim oldDelegate) =>
      oldDelegate.colors != colors;
}
