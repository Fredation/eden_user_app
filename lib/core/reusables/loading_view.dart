import 'package:eden_user_app/core/data_utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaderView extends StatelessWidget {
  final bool loading;
  final Widget child;
  final bool overlay;
  final Color? backgroundColor;
  const LoaderView(
      {Key? key,
      required this.loading,
      required this.child,
      this.overlay = true,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // backgroundColor: Colors.transparent,
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: AbsorbPointer(absorbing: loading, child: getView(context)),
    );
  }

  Widget getView(context) {
    if (overlay) {
      return Stack(
        children: [
          child,
          if (loading)
            Stack(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.75),
                ),
                Center(
                    child: LoadingAnimationWidget.inkDrop(
                  color: EdenColors.primaryGreen,
                  size: 60,
                )),
              ],
            ),
        ],
      );
    } else {
      return loading
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
              color: EdenColors.primaryGreen,
              size: 60,
            ))
          : child;
    }
  }
}
