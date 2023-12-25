import 'package:flutter/material.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/pages/reorder_page.dart';
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

  bool isEditMode = false;
  Key _contentKey = UniqueKey();

  callback() {
    setState(() {reload = true; _contentKey = UniqueKey();});
  }

  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomAppBar(
          bodyTale: buildBody(device),
          showIcon: true,
          isScrollable: !isEditMode,
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
            // physics: isEditMode ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
            // physics: isEditMode ? const FixedExtentScrollPhysics() : const AlwaysScrollableScrollPhysics(),
            physics: NeverScrollableScrollPhysics(),
            child: TaleBuilder(callback: callback, isEditMode: isEditMode, reload: reload, taleKey: _contentKey),
          ),
          // TaleBuilder(callback: callback, isEditMode: isEditMode, reload: reload, taleKey: _contentKey),
          buildAddMemory(),
          isEditMode ? buildReorder() : Container(),
          buildEditModeButton(),
        ],
      ),
    );
  }

  // Widget buildMemories() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [buildAddMemory()],
  //     ),
  //   );
  // }

  Widget buildEditModeButton() {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return Positioned(
        top: 20,
        right: 10,
        child: GestureDetector(
          onTap: () {
            setState(() {
              isEditMode = !isEditMode;
            });
          },
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 3, spreadRadius: 3)],
                borderRadius: BorderRadius.circular(30),
                color: AppColors.main2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(30),
                        color: isEditMode
                            ? AppColors.main2
                            : AppColors.main1),
                    child: Center(
                        child: Text(
                          'View',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isEditMode
                                  ? Colors.black
                                  : Colors.white),
                        )),
                  ),
                  Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(30),
                        color: isEditMode
                            ? AppColors.main3
                            : AppColors.main2),
                    child: Center(
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isEditMode
                                  ? Colors.white
                                  : Colors.black),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  Widget buildReorder() {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return Positioned(
      bottom: 25,
      left: 20,
      child: GestureDetector(
        onTap: () {
          onReorderButtonClick();
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 3, spreadRadius: 3)],
              borderRadius: BorderRadius.circular(30),
              color: AppColors.main2),
          child: const Center(
              child: Text(
                'Reorder',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
        ),
      ),
    );
  }

  void onReorderButtonClick() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ReorderPage();
        }
    ).then((value) => setState(() {
      callback();
    }));
    // if (result != null && result == true) {
    //   setState(() {
    //     callback();
    //   });
    // }
  }

  Widget buildAddMemory() {
    return ButtonSlider(callback: callback,);
  }
}
