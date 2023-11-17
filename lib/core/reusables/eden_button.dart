import 'package:eden_user_app/core/data_utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EdenButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final void Function()? onPressed;
  final bool isFilled;
  final Color? textColor;
  final Color? color;
  final bool isDisabled;
  final Widget? leading;
  final Widget? trailing;
  final bool useLightText;
  final Color? borderColor;
  final bool loading;
  const EdenButton({
    Key? key,
    required this.text,
    this.height = 50,
    this.width = double.infinity,
    this.isFilled = true,
    required this.onPressed,
    this.isDisabled = false,
    this.textColor,
    this.color,
    this.leading,
    this.trailing,
    this.useLightText = false,
    this.borderColor,
    this.loading = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isDisabled,
      child: InkWell(
        onTap: loading
            ? null
            : () {
                HapticFeedback.lightImpact();
                onPressed!();
              },
        // splashColor: Colors.amberAccent,
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          // color: fillColor!,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: loading
                ? EdenColors.lightTextColor
                : isDisabled
                    ? EdenColors.lightTextColor
                    : color ?? (isFilled ? EdenColors.primaryGreen : null),
            border:
                borderColor == null ? null : Border.all(color: borderColor!),
          ),
          child: loading
              ? const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: EdenColors.primaryGreen,
                    ),
                  ),
                )
              : FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (leading != null) ...[
                        leading!,
                        const SizedBox(width: 10),
                      ],
                      Text(text,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: loading
                                        ? EdenColors.textColor
                                        : isDisabled
                                            ? EdenColors.textColor
                                            : (isFilled
                                                ? Colors.white
                                                : EdenColors.primaryGreen),
                                  )),
                      if (trailing != null) ...[
                        const SizedBox(width: 10),
                        trailing!,
                      ],
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
