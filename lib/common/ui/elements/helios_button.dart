import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';

class HeliosButton extends StatefulWidget {
  const HeliosButton({
    super.key,
    required this.onTap,
    this.label,
    this.color,
    this.gradient,
  }) : assert(
            color != null && gradient == null ||
                color == null && gradient != null,
            "Either color or gradient should be provided");

  final String? label;
  final Color? color;
  final Gradient? gradient;
  final GestureTapCallback onTap;

  @override
  State<HeliosButton> createState() => _HeliosButtonState();
}

class _HeliosButtonState extends State<HeliosButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.065,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          child: Ink(
            decoration: BoxDecoration(
              color: widget.color,
              gradient: widget.gradient,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Text(
                  widget.label ?? "",
                  style: AppTheme.of(context).themeData.textTheme.labelMedium,
                ),
                InkWell(
                  splashColor: AppTheme.of(context)
                      .themeData
                      .colorScheme
                      .background
                      .withOpacity(0.7),
                  onTap: widget.onTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
