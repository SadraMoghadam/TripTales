import 'package:flutter/material.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/button_slider.dart';
import 'package:trip_tales/src/widgets/container_movement_handler.dart';
import '../constants/color.dart';
import '../utils/device_info.dart';
import '../widgets/menu_bar_tale.dart';
import '../widgets/tale_builder.dart';

class TalePage extends StatelessWidget {
  const TalePage({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CustomAppBar(
          body_tale: buildBody(device),
          isPinned: true,
        ));
  }

  Widget buildBody(DeviceInfo device) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_tale.jpg'),
              fit: BoxFit.cover,
              opacity: 0.3)),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: TaleBuilder(),
          ),
          buildAddMemory(),
        ],
      ),
    );
  }

  Widget buildMemories() {
    return SingleChildScrollView(
      child: Column(
        children: [buildAddMemory()],
      ),
    );
  }

  Widget buildAddMemory() {
    return ButtonSlider();
  }
}
