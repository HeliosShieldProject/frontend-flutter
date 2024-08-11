import 'package:flutter/material.dart';

class HeliosListTile extends StatelessWidget {
  const HeliosListTile({
    super.key,
    this.titleWidget,
    required this.children,
  });

  final Widget? titleWidget;
  final List<Widget> children;

  List<Widget> effectiveChildren(BuildContext context) {
    var _children = <Widget>[];
    titleWidget != null
        ? _children.addAll(<Widget>[
            titleWidget!,
            const SizedBox(
              height: 20,
            ),
          ])
        : null;
    for (int i = 0; i < children.length; i++) {
      i == 0
          ? _children.add(children[i])
          : _children.addAll(
              <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.onSurface,
                  height: 0,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                children[i],
              ],
            );
    }
    return _children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: effectiveChildren(context),
      ),
    );
  }
}
