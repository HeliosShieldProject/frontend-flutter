import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Widget effectiveSubButton(BuildContext context) {
    return switch(AppUserSettings.of(context).subscriptionType) {
      SubscriptionType.free => HeliosButton(
        labelWidget: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[Text("Обновитесь до Premium", style: Theme.of(context).textTheme.labelMedium,),],),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      SubscriptionType.premium => HeliosButton(
            labelWidget: Row(
              children: [
                Text("Premium", style: Theme.of(context).textTheme.headlineMedium,),
                Expanded(child: Container(),),
                Text("1/2", style: Theme.of(context).textTheme.headlineMedium,)
              ],
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: <Color>[
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary
              ],
              stops: const <double>[
                0.3,
                0.7,
              ]
            ),
          ),
      SubscriptionType.superPremium => HeliosButton(
            labelWidget: Row(
              children: [
                Text("Super Premium", style: Theme.of(context).textTheme.headlineMedium,),
                Expanded(child: Container(),),
                Text("2/2", style: Theme.of(context).textTheme.headlineMedium,)
              ],
            ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary
              ],
              stops: const <double>[
                0.3,
                0.7,
              ]
            ),
          ),
      null => throw UnimplementedError(),
    };
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).colorScheme.onBackground,), padding: const EdgeInsets.only(left: 20), onPressed: () => Navigator.of(context).maybePop(),),
      title: Text("Параметры", style: Theme.of(context).textTheme.headlineMedium),
    ),
    body: Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          effectiveSubButton(context),
        ],
      ),
    )
  );
}