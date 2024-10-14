import 'package:Helios/common/constants/constants.dart';
import 'package:Helios/common/countries/countries_constants.dart';
import 'package:Helios/common/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: double.infinity,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: NumericConstants.horizontalPadding,
            ),
            child: SvgPicture.asset(
              fit: BoxFit.scaleDown,
              "assets/helios_icon.svg",
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface,
                BlendMode.src,
              ),
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
                color: colorScheme.surface,
                size: 25,
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                RouteNames.settings,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: NumericConstants.horizontalPadding,
          right: NumericConstants.horizontalPadding,
          bottom: NumericConstants.bottomPadding,
        ),
        child: Column(children: <Widget>[
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: null,
                child: SvgPicture.asset(
                  "assets/shield_icon.svg",
                  colorFilter: ColorFilter.mode(
                    colorScheme.surface,
                    BlendMode.src,
                  ),
                  height: 140,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          const HeliosVpnCard(
            connected: false,
            currentCountry: CountriesConstants.ru,
            uploadSpeed: 21.7,
            downloadSpeed: 15.6,
          ),
        ]),
      ),
    );
  }
}
