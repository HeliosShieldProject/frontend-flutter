import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helios/common/common.dart';
import 'elements/elements.dart';

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
            currentCountry: CountriesConstants.ru,
            uploadSpeed: 21.7,
            downloadSpeed: 15.6,
          ),
        ]),
      ),
    );
  }
}
