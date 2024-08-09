import 'dart:math';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helios/common/common.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: double.infinity,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset(
              fit: BoxFit.scaleDown,
              "assets/helios_icon.svg",
              color: Theme.of(context).colorScheme.onBackground,
              height: 20,
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.onBackground,
                size: 25,
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(RouteNames.settings),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 40,
        ),
        child: Column(children: <Widget>[
          Expanded(
            child: Center(
              child: SvgPicture.asset(
                "assets/shield_icon.svg",
                color: Theme.of(context).colorScheme.onBackground,
                height: 140,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          const HeliosVpnCard(
            connected: false,
            // currentCountry: CountriesConstants.ru,
            // uploadSpeed: 21.7,
            // downloadSpeed: 15.6,
          ),
        ]),
      ),
    );
  }
}

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
  late AnimationController _controller;
  late Animation<Gradient> _animation;

  Widget get effectiveCountryIcon {
    return widget.currentCountry == null
        ? AnimatedBuilder(
            animation: _animation,
            builder: (context, _) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: _animation.value,
              ),
              height: 37,
              width: 37,
            ),
          )
        : CountryFlag.fromCountryCode(
            widget.currentCountry!.countryCode,
            shape: const Circle(),
            height: 37,
            width: 37,
          );
  }

  Widget get effectiveCountryName {
    return widget.currentCountry == null
        ? AnimatedBuilder(
            animation: _animation,
            builder: (context, _) => Container(
              width: 148,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: _animation.value,
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) => Container(
        width: 83,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: _animation.value,
        ),
      ),
    );
  }

  Widget get effectiveDownloadText {
    return widget.downloadSpeed == null
        ? Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, _) => Container(
                      width: 30,
                      height: 21,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: _animation.value,
                      ),
                    ),
                  ),
                ),
                TextSpan(
                  text: " Mb/s",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          )
        : Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.downloadSpeed!.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextSpan(
                  text: " Mb/s",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          );
  }

  Widget get effectiveUploadText {
    return widget.uploadSpeed == null
        ? Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, _) => Container(
                      width: 30,
                      height: 21,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: _animation.value,
                      ),
                    ),
                  ),
                ),
                TextSpan(
                  text: " Mb/s",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          )
        : Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.uploadSpeed!.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextSpan(
                  text: " Mb/s",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));

    _animation = GradientTween()
        .chain(CurveTween(curve: Curves.ease))
        .animate(_controller);

    if (widget.downloadSpeed == null ||
        widget.uploadSpeed == null ||
        widget.currentCountry == null) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant HeliosVpnCard oldWidget) {
    if ((widget.downloadSpeed == null ||
            widget.uploadSpeed == null ||
            widget.currentCountry == null) &&
        _controller.status != AnimationStatus.forward) {
      _controller.repeat();
      setState(() {});
    } else if (!(widget.downloadSpeed == null ||
            widget.uploadSpeed == null ||
            widget.currentCountry == null) &&
        _controller.status == AnimationStatus.forward) {
      _controller.stop();
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    const double cardHeight = 150;

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: theme.colorScheme.surface,
        ),
        height: cardHeight,
        child: Column(
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                height: cardHeight / 2,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                            width: 45,
                          ),
                          child: CustomPaint(
                            painter: CustomTrim(
                              colors: widget.connected
                                  ? <Color>[
                                      theme.colorScheme.secondary,
                                      theme.colorScheme.primary
                                    ]
                                  : null,
                            ),
                            size: const Size.fromHeight(45),
                          ),
                        ),
                        effectiveCountryIcon,
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(child: effectiveCountryName),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(child: effectiveCountryIp),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Divider(
                thickness: 2,
                height: 0,
                color: theme.colorScheme.onSurface,
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                height: cardHeight / 2,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.arrow_downward_rounded,
                      size: 25,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        effectiveDownloadText,
                        Text.rich(
                          TextSpan(
                            text: "загрузка",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    const Icon(
                      Icons.arrow_upward_rounded,
                      size: 25,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        effectiveUploadText,
                        Text.rich(
                          TextSpan(
                            text: "выгрузка",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
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
        Colors.white
            .withOpacity(0.1 + 0.1 * (-pow(t * 2 - 1, 2).toDouble() + 1)),
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
              begin: Alignment(-0.5, -0.5),
              end: Alignment.bottomRight,
            ).createShader(Rect.fromCenter(
              center: Offset(size.width / 2, size.height / 2),
              width: size.width,
              height: size.height))
          : null;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomTrim oldDelegate) =>
      oldDelegate.colors != colors;
}
