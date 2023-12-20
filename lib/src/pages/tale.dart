import 'package:flutter/material.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/button_slider.dart';
import '../utils/device_info.dart';
import '../widgets/tale_builder.dart';

class TalePage extends StatelessWidget {
  const TalePage({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomAppBar(
          bodyTale: buildBody(device),
          showIcon: true,
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
