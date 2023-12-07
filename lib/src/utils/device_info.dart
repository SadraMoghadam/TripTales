import 'package:flutter/cupertino.dart';

class DeviceInfo {
  var orientation;
  var height;
  var width;

  void computeDeviceInfo(BuildContext context)
  {
    orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
  }
}

class GlobalContextService {
  static GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
}