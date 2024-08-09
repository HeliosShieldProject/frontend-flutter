import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helios/common/common.dart';
import 'package:helios/settings/settings_page.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          "Внешний вид",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
        child: Column(
          children: [
            HeliosListTile(
              titleWidget: Text(
                "Тема",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        HeliosThemeButton(
                          assetName:
                              "assets/${SelectedTheme.values[0].name}.svg",
                          selectedTheme: SelectedTheme.values[0],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          SelectedTheme.values[0].name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Column(
                      children: [
                        HeliosThemeButton(
                          assetName:
                              "assets/${SelectedTheme.values[1].name}.svg",
                          selectedTheme: SelectedTheme.values[1],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          SelectedTheme.values[1].name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Column(
                      children: [
                        HeliosThemeButton(
                          assetName:
                              "assets/${SelectedTheme.values[2].name}.svg",
                          selectedTheme: SelectedTheme.values[2],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          SelectedTheme.values[2].name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: Container(),
            ),
            HeliosButton(
              color: Theme.of(context).colorScheme.onBackground,
              label: "Готово",
              onTap: () => Navigator.of(context).maybePop(),
            )
          ],
        ),
      ),
    );
  }
}

class HeliosThemeButton extends StatefulWidget {
  const HeliosThemeButton({
    super.key,
    required this.assetName,
    required this.selectedTheme,
  });

  final String assetName;
  final SelectedTheme selectedTheme;

  @override
  State<HeliosThemeButton> createState() => _HeliosThemeButtonState();
}

class _HeliosThemeButtonState extends State<HeliosThemeButton> {
  late bool selected;

  @override
  void didChangeDependencies() {
    setState(() {
      selected = (AppUserSettings.of(context, listen: true).selectedTheme ==
          widget.selectedTheme);
    });
    super.didChangeDependencies();
  }

  Color effectiveColor(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return selected ? colorScheme.primary : colorScheme.onSurface;
  }

  @override
  Widget build(BuildContext context) {
    const double width = 75;

    return Container(
      height: width * (18.9 / 9),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: effectiveColor(context),
        ),
      ),
      padding: const EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          children: [
            SvgPicture.asset(
              widget.assetName,
              fit: BoxFit.fitHeight,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  final SelectedTheme oldSelectedTheme =
                      AppUserSettings.of(context).selectedTheme!;
                  if (oldSelectedTheme != widget.selectedTheme) {
                    AppUserSettings.changeTheme(context, widget.selectedTheme);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
