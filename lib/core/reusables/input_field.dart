import 'package:eden_user_app/core/data_utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EdenInputField extends StatelessWidget {
  const EdenInputField({
    super.key,
    this.label,
    required this.controller,
    this.initialValue,
    this.obscureText = false,
    this.textStyle = const TextStyle(),
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.validator,
    this.hintText = "",
    // required this.errorText,
    this.textInputAction = TextInputAction.done,
    this.prefixText,
    this.maxlines = 1,
    this.onChanged,
    this.contentPadding,
    this.inputFormatters,
    this.readOnly = false,
    this.letterSpacing,
    this.enabled = true,
  });
  final String? label;
  final TextEditingController controller;
  final String? initialValue;
  final bool obscureText;
  final TextStyle textStyle;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final String? hintText;
  // String? errorText;
  final TextInputAction textInputAction;
  final String? prefixText;
  final int maxlines;
  final Function(String)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final double? letterSpacing;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        const SizedBox(height: 4),
        TextFormField(
          readOnly: readOnly,
          validator: validator,
          controller: controller,
          initialValue: initialValue,
          focusNode: focusNode,
          keyboardType: textInputType,
          obscureText: obscureText,
          textInputAction: textInputAction,
          maxLines: maxlines,
          textAlignVertical: TextAlignVertical.center,
          onChanged: onChanged,
          enabled: enabled,
          inputFormatters: inputFormatters,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(letterSpacing: letterSpacing),
          decoration: InputDecoration(
            isDense: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  const BorderSide(color: EdenColors.lightTextColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  const BorderSide(color: EdenColors.lightTextColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  const BorderSide(color: EdenColors.lightTextColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  const BorderSide(color: EdenColors.errorColor, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  const BorderSide(color: EdenColors.errorColor, width: 1),
            ),
            // errorStyle: const TextStyle(
            //   height: 0,
            //   fontSize: 0,
            //   color: Colors.transparent,
            // ),
            fillColor:
                // errorText != null
                //     ? const Color.fromRGBO(255, 244, 244, 1)
                //     :
                enabled ? Colors.white : EdenColors.lightTextColor,
            filled: true,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            suffixIconConstraints: const BoxConstraints(
              minHeight: 20,
              minWidth: 20,
            ),
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            prefixText: prefixText,
          ),
        ),
      ],
    );
  }
}
