import 'package:flutter/material.dart';

class ComonTextField extends StatelessWidget {
  final Key? key;
  final TextEditingController? controller;
  final String? labelText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final bool? enabled;
  final bool? readOnly;
  final bool? autofocus;
  final bool? autocorrect;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final int? maxLenghtEnforced;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final Widget? prefixicon;
  final Widget? suffixicon;
  final Widget? suffix;
  final Widget? prefix;
  final Text? prefixtext;
  final Text? sufixtext;
  final Text? hintText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode? autovalidateMode;
  final InputDecoration? decoration;

  const ComonTextField({
    this.key,
    this.nextFocus,
    this.controller,
    this.labelText,
    this.obscureText = false,
    this.keyboardType,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.maxLenghtEnforced,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.textInputAction,
    this.focusNode,
    this.prefixicon,
    this.suffixicon,
    this.suffix,
    this.prefix,
    this.prefixtext,
    this.sufixtext,
    this.hintText,
    this.hintStyle,
    this.labelStyle,
    this.contentPadding,
    this.autovalidateMode,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: decoration ??
          InputDecoration(
            counterText: '',
            labelText: labelText,
            prefixIcon: prefixicon,
            suffixIcon: prefixicon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
      key: key,
      controller: controller,
      obscureText: obscureText!,
      keyboardType: keyboardType,
      enabled: enabled,
      readOnly: readOnly!,
      autofocus: autofocus!,
      autocorrect: autocorrect!,
      autovalidateMode: autovalidateMode,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      onChanged: onChanged,
      validator: validator,
      onSaved: onSaved,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (term) {
        if (nextFocus != null) {
          focusNode!.unfocus();
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
    );
  }
}
