import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/models/tale_model.dart';
import 'package:trip_tales/src/services/tale_service.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/tale_card.dart';
import '../utils/app_manager.dart';
import '../utils/device_info.dart';

class MyTalesPage extends StatefulWidget {
  @override
  _MyTalesPage createState() => _MyTalesPage();
}

class _MyTalesPage extends State<MyTalesPage> {
  final TaleService _taleService = Get.find<TaleService>();
  late Future<List<TaleModel?>> tales;
  List<ValueKey> _widgetKeyList = List<ValueKey>.empty(growable: true);
  final AppManager _appManager = Get.put(AppManager());

  static int numOfTales = 0;

  @override
  void initState() {
    setState(() {
      tales = _taleService.getTales(_appManager.getCurrentUser());
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return buildBody();
    //   Scaffold(
    //   //debugShowCheckedModeBanner: false,
    //   body: CustomAppBar(
    //     bodyTale: buildBody(),
    //     showIcon: false,
    //   ),
    // );
    //  );
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        newTaleButton(),
        Flexible(
          fit: FlexFit.tight,
          flex: 14,
          child: buildCards(),
        ),
        /*
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: buildFooter(),
        ),
        */
      ],
    );
  }

  Widget buildCards() {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return FutureBuilder<List<TaleModel?>>(
      future: tales,
      builder:
          (BuildContext context, AsyncSnapshot<List<TaleModel?>> snapshot) {
        if (snapshot.hasData) {
          List<TaleModel?> data = snapshot.data!;
          numOfTales = data.length;
          for (int i = 0; i < numOfTales; i++) {
            _widgetKeyList.add(ValueKey(i +
                data[i]!.id!.codeUnits.fold<int>(
                    0,
                        (previousValue, element) =>
                    previousValue * 256 + element)));
          }
          // If the device is a tablet and in landscape mode, make the SingleChildScrollView scroll horizontally and change the Column to a Row
          if (isLandscape && isTablet) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < numOfTales; i++)
                    CustomTale(
                      key: _widgetKeyList[i],
                      talePath: data[i]!.imagePath,
                      taleName: data[i]!.name,
                      index: i,
                      isLiked: data[i]!.liked,
                    ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < numOfTales; i++)
                    CustomTale(
                      key: _widgetKeyList[i],
                      talePath: data[i]!.imagePath,
                      taleName: data[i]!.name,
                      index: i,
                      isLiked: data[i]!.liked,
                    ),
                ],
              ),
            );
          }
        } else if (snapshot.hasError) {
          // print(snapshot.error);
          return Text("Error: ${snapshot.error}");
        } else {
          return Container();
        }
      },
    );
  }

/*
  Widget buildCards() {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return FutureBuilder<List<TaleModel?>>(
      future: tales,
      builder:
          (BuildContext context, AsyncSnapshot<List<TaleModel?>> snapshot) {
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          // print("###########");
          List<TaleModel?> data = snapshot.data!;
          // print(snapshot.data!);
          numOfTales = data.length;
          for (int i = 0; i < numOfTales; i++) {
            _widgetKeyList = List.generate(
                numOfTales,
                (index) => GlobalObjectKey<FormState>(index +
                    data[i]!.name.codeUnits.fold<int>(
                        0,
                        (previousValue, element) =>
                            previousValue * 256 + element)));
          }
          Set<GlobalKey<State<StatefulWidget>>> uniqueSet = Set.from(_widgetKeyList);
          _widgetKeyList = uniqueSet.toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < numOfTales; i++)
                  CustomTale(
                    // key: _widgetKeyList[i],
                    talePath: data[i]!.imagePath,
                    taleName: data[i]!.name,
                    index: i,
                    isLiked: data[i]!.liked,
                  ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          // print(snapshot.error);
          return Text("Error: ${snapshot.error}");
        } else {
          return Container();
        }
      },
    );
  }
  */

  Widget newTaleButton() {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed('/createTalePage');
      },
      child: Center(
        child: Container(
          width: isTablet ? 120 : 100,
          height: isTablet ? 120 : 100,
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.main2,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, blurRadius: 3, offset: Offset(-5, 5))
              ],
              border: Border(
                top: BorderSide(color: AppColors.main1, width: 5),
                right: BorderSide(color: AppColors.main1, width: 5),
                bottom: BorderSide(color: AppColors.main1, width: 5),
                left: BorderSide(color: AppColors.main1, width: 5),
              )
              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //   image: AssetImage('assets/images/createTale_background.png'),
              // ),
              ),
          child: const Center(
            // Add this
            child: Text(
              '+',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 60.0,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(-2.0, 2.0),
                    blurRadius: 3.0,
                    color: AppColors.main1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

/*
  Widget newTaleButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/createTalePage');
      },
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.main2,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, blurRadius: 3, offset: Offset(-5, 5))
              ],
              border: Border(
                top: BorderSide(color: AppColors.main1, width: 5),
                right: BorderSide(color: AppColors.main1, width: 5),
                bottom: BorderSide(color: AppColors.main1, width: 5),
                left: BorderSide(color: AppColors.main1, width: 5),
              )
              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //   image: AssetImage('assets/images/createTale_background.png'),
              // ),
              ),
          child: const Text(
            textAlign: TextAlign.center,
            '+',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 60.0,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(-2.0, 2.0),
                  blurRadius: 3.0,
                  color: AppColors.main1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  */
}
