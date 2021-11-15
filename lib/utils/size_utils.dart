import 'package:flutter/cupertino.dart';

class SizeUtils {
  static double fromWidth(BuildContext context, double value) {
    return MediaQuery.of(context).size.width * value;
  }

  static double fromHeight(BuildContext context, double value) {
    return MediaQuery.of(context).size.height * value;
  }
}
