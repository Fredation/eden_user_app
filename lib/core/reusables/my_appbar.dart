import 'package:eden_user_app/core/data_utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EdenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Function? onPressed;
  final Widget? bottom;
  final List<Widget>? actions;
  final double bottomHeight;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? titleColor;
  final Widget? leading;

  const EdenAppBar(
      {Key? key,
      this.title,
      this.onPressed,
      this.bottom,
      this.actions,
      this.bottomHeight = 100,
      this.backgroundColor,
      this.textColor,
      this.titleColor,
      this.leading})
      : super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(bottom == null ? kToolbarHeight : bottomHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? EdenColors.background,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: backgroundColor ?? EdenColors.background,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
      centerTitle: true,
      scrolledUnderElevation: 0.0,
      elevation: 0,
      title: Text(
        title ?? ' ',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: titleColor ?? EdenColors.textColor,
            ),
      ),
      bottom: bottom == null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(0), child: Container())
          : PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: bottom!,
            ),
      // primary: false,
      leading: leading ??
          GestureDetector(
            onTap: () {
              if (onPressed != null) {
                onPressed!();
              } else {
                FocusScope.of(context).unfocus();
                Navigator.maybePop(context, true);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: textColor ?? EdenColors.textColor,
                  size: 26,
                ),
              ],
            ),
          ),
      actions: actions,
    );
  }
}
