import 'package:flutter/material.dart';

class AppUtil {
  /// Dismissises Keyboard From Anywhere
  static void dismissKeyboard({required BuildContext context}) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  static String generateSimpleId() {
    return '${DateTime.now().millisecondsSinceEpoch}-${(1000 + (9999 - 1000) * (DateTime.now().millisecondsSinceEpoch % 1)).toInt()}';
  }
}
