import 'package:flutter/material.dart';

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
    this.clearOnError = true,
  });

  final TextEditingController controller;
  final String text;
  final String textOnError;
  final bool Function(String?) validityCriteria;
  final bool obscureText;
  final bool clearOnError;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;

  @override
  State<HeliosFormTextField> createState() => _HeliosFormTextFieldState();
}

class _HeliosFormTextFieldState extends State<HeliosFormTextField> {
  late final FocusNode focusNode;
  bool obscureText = true;
  bool error = false;
  bool showSuffix = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    if (widget.obscureText) {
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
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.text,
      child: GestureDetector(
        onTap: () {
          if (!focusNode.hasFocus) {
            focusNode.requestFocus();
          }
        },
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: error ? Border.all(color: Colors.red, width: 3) : null,
          ),
          alignment: Alignment.centerLeft,
          child: TextFormField(
            focusNode: focusNode,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText ? obscureText : false,
            autocorrect: false,
            cursorColor: Theme.of(context).colorScheme.primary,
            cursorErrorColor: Theme.of(context).colorScheme.primary,
            style: Theme.of(context).textTheme.bodyMedium,
            textInputAction: widget.textInputAction,
            decoration: InputDecoration(
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: error ? widget.textOnError : widget.text,
              labelStyle: error
                  ? Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.red)
                  : Theme.of(context).textTheme.bodyMedium,
              errorStyle: const TextStyle(
                color: Colors.transparent,
                height: 0,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              suffixIcon: showSuffix
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: Icon(obscureText
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                    )
                  : null,
            ),
            validator: (value) {
              if (!widget.validityCriteria(value)) {
                if (!error) {
                  setState(() {
                    error = true;
                  });
                  if (widget.clearOnError) {
                    widget.controller.clear();
                  }
                }
                return '';
              }
              return null;
            },
            onChanged: (value) {
              if (error && widget.validityCriteria(value)) {
                setState(() {
                  error = false;
                });
              }
            },
            onEditingComplete: widget.textInputAction == TextInputAction.next
                ? () {
                    do {
                      FocusScope.of(context).nextFocus();
                    } while ((FocusScope.of(context)
                                .focusedChild
                                ?.context
                                ?.widget as Focus)
                            .debugLabel !=
                        "EditableText");
                  }
                : null,
          ),
        ),
      ),
    );
  }
}
