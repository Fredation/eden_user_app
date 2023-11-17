import 'package:eden_user_app/core/data_utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AppUtil {
  static Widget showInfoCard(BuildContext context,
      {required String text, bool error = false}) {
    return Container(
      decoration: BoxDecoration(
          color: error ? const Color(0xffFFE9E7) : const Color(0xffE5FBF3),
          border: Border.all(
            color: error ? EdenColors.errorColor : EdenColors.primaryGreen,
          ),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(10),
      child: Material(
        color: error ? const Color(0xffFFE9E7) : const Color(0xffE5FBF3),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }

  static showSnackBar(BuildContext context,
      {required String text, bool error = false}) {
    return showTopSnackBar(
      Overlay.of(context),
      Container(
        decoration: BoxDecoration(
            color: error ? const Color(0xffFFE9E7) : const Color(0xffE5FBF3),
            border: Border.all(
              color: error ? EdenColors.errorColor : EdenColors.primaryGreen,
            ),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(10),
        child: Material(
          color: error ? const Color(0xffFFE9E7) : const Color(0xffE5FBF3),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
