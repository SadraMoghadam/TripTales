import 'package:flutter/cupertino.dart';

class DeviceInfo {
  var orientation;
  var height;
  var width;
  late bool isTablet;

  void computeDeviceInfo(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    // Use MediaQuery to get the screen size
    double screenWidth = MediaQuery.of(context).size.width;

    // Define a threshold to determine tablet size
    double tabletThreshold = 600.0;

    // Check if the screen width is greater than the tablet threshold
    isTablet = screenWidth > tabletThreshold;
  }
}

class GlobalContextService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
