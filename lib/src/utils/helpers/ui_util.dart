import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';


class UiUtil {
  /// OPENS BOTTOM SHEET WITH THE GIVEN WIDGET
  static Future openBottomSheet({
    required BuildContext context,
    required Widget widget,
    BoxConstraints? constraints, 
  }) async {
    return await showModalBottomSheet(
      context: context,
      builder: (ctx) => widget,
      isScrollControlled: true,
      constraints: constraints,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: AppDefaults.bottomSheetRadius,
      ),
    );
  }

  /// Opens dialog with background blur enabled
  static Future openDialog({
    required BuildContext context,
    required Widget widget,
    bool isDismissable = true,
  }) async {
    return await showGeneralDialog(
      barrierLabel: 'Dialog',
      barrierDismissible: isDismissable,
      context: context,
      pageBuilder: (ctx, anim1, anim2) => widget,
      transitionBuilder: (ctx, anim1, anim2, child) => ScaleTransition(
        scale: anim1,
        child: child,
      ),
    );
  }
}
