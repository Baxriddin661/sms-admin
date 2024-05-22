import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:etcsms/manager/locator.dart';



final LoaderManager loaderManager = locator.get<LoaderManager>();

class LoaderManager {
  LoaderManager() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 60.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.grey.withOpacity(0.4)
      ..userInteractions = false
      ..maskType = EasyLoadingMaskType.custom
      ..backgroundColor = Colors.white.withOpacity(.2)
      ..dismissOnTap = false;
  }

  void showError(String message) {
    EasyLoading.showError(message,
        duration: Duration(seconds: 2), dismissOnTap: false);
  }

  void showLoader() {
    EasyLoading.show();
  }

  void hideLoader() {
    EasyLoading.dismiss();
  }
}
