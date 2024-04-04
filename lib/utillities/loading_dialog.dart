import 'package:flutter/material.dart';

class LoaderDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          key: key,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Center(
            child: Image.asset(
              'assets/images/loading.gif',
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.height * 0.10,
            ),
          ),
        );
      },
    );
  }

  static Future<void> showNoInternet(BuildContext context, GlobalKey key) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          key: key,
          elevation: 0.0,
          backgroundColor: Colors.white,
          child: Center(
            child: Image.asset(
              'assets/images/loading.gif',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        );
      },
    );
  }
}