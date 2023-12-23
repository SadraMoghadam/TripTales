import 'package:flutter/material.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/button_slider.dart';
import '../utils/device_info.dart';
import '../widgets/tale_builder.dart';

class TalePage extends StatefulWidget {
  const TalePage({super.key});

  @override
  State<TalePage> createState() => _TalePageState();
}

class _TalePageState extends State<TalePage> {
  bool reload = false;
  callback() {
    print("IIIIIIIIIIIMMMMMMMMMMMMM HHHHHHHHHHHEEEEEEEEEEEE");
    setState(() {reload = true;});
  }

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
            child: TaleBuilder(callback: callback,),
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
    return ButtonSlider(callback: callback,);
  }
}
