import 'package:flutter/material.dart';

/// Helios Form Text Field compliant to the design patterns of the Helios app
class HeliosFormTextField extends StatefulWidget {
  const HeliosFormTextField({
    super.key,
    required this.controller,
    required this.text,
    required this.textOnError,
    required this.validityCriteria,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String text;
  final String textOnError;
  final bool Function(String?) validityCriteria;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;

  @override
  State<HeliosFormTextField> createState() => _HeliosFormTextFieldState();
}

class _HeliosFormTextFieldState extends State<HeliosFormTextField> {
  late final FocusNode passwordFocusNode;
  late final FocusNode suffixIconFocusNode;

  bool obscureText = true;
  bool error = false;
  bool showSuffix = false;

  late ThemeData themeData;

  @override
  void initState() {
    super.initState();
    passwordFocusNode = FocusNode();
    if (widget.obscureText) {
      suffixIconFocusNode = FocusNode();
      widget.controller.addListener(() {
        if (!showSuffix && widget.controller.text.isNotEmpty) {
          setState(() {
            showSuffix = true;
          });
        } else if (showSuffix && widget.controller.text.isEmpty) {
          setState(() {
            showSuffix = false;
          });
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    themeData = Theme.of(context);
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    if (widget.obscureText) suffixIconFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.text,
        child: GestureDetector(
          onTap: () {
            if (!passwordFocusNode.hasFocus) {
              passwordFocusNode.requestFocus();
            }
          },
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: themeData.colorScheme.tertiary,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: error ? Border.all(color: Colors.red, width: 3) : null,
            ),
            alignment: Alignment.centerLeft,
            child: TextFormField(
              focusNode: passwordFocusNode,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText ? obscureText : false,
              autocorrect: false,
              cursorColor: themeData.colorScheme.primary,
              cursorErrorColor: themeData.colorScheme.primary,
              style: themeData.textTheme.labelMedium!.copyWith(
                color: Colors.white.withOpacity(
                  0.5,
                ),
              ),
              textInputAction: widget.textInputAction,
              decoration: InputDecoration(
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: _effectiveLabelText,
                labelStyle: _effectiveLabelStyle(context),
                errorStyle: _errorStyle,
                suffixIcon: _effectiveSuffixIcon,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                isDense: true,
              ),
              validator: _validator,
              onChanged: _onChanged,
              onEditingComplete: _onEditingComplete,
            ),
          ),
        ),
      );

  String get _effectiveLabelText => error ? widget.textOnError : widget.text;

  TextStyle _effectiveLabelStyle(BuildContext context) => error
      ? Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Colors.red,
          )
      : Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Colors.white.withOpacity(
              0.5,
            ),
          );

  TextStyle get _errorStyle => const TextStyle(
        color: Colors.transparent,
        fontSize: 0,
      );

  Widget? get _effectiveSuffixIcon => showSuffix
      ? Padding(
          padding: const EdgeInsets.only(right: 7),
          child: IconButton(
            focusNode: suffixIconFocusNode,
            icon: Icon(
              obscureText
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              color: Colors.white.withOpacity(0.5),
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
        )
      : null;

  String? _validator(value) {
    if (!widget.validityCriteria(value)) {
      if (!error) {
        setState(() {
          error = true;
        });
      }
      return '';
    }
    return null;
  }

  void _onChanged(value) {
    if (error && widget.validityCriteria(value)) {
      setState(() {
        error = false;
      });
    }
  }

  VoidCallback? get _onEditingComplete =>
      widget.textInputAction == TextInputAction.next
          ? () {
              passwordFocusNode.nextFocus();
              if (showSuffix) {
                suffixIconFocusNode.nextFocus();
              }
            }
          : null;
}
