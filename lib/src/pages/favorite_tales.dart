import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/models/tale_model.dart';
import 'package:trip_tales/src/services/tale_service.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/tale_card.dart';
import 'package:trip_tales/src/widgets/text_field.dart';
import '../utils/app_manager.dart';
import '../utils/device_info.dart';

class FavoriteTalesPage extends StatefulWidget {
  @override
  _FavoriteTalesPage createState() => _FavoriteTalesPage();
}

class _FavoriteTalesPage extends State<FavoriteTalesPage> {
  final TaleService _taleService = Get.find<TaleService>();
  late Future<List<TaleModel?>> tales;
  List<GlobalKey> _widgetKeyList = List<GlobalKey>.empty(growable: true);
  final AppManager _appManager = Get.put(AppManager());

  static int numOfTales = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      tales = _taleService.getFavoriteTales(_appManager.getCurrentUser());
    });
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
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    bool isTablet = device.isTablet;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(isTablet ? 15.0 : 10), // Add this
              child: Text(
                'Your favorite Tales',
                style: TextStyle(
                    color: AppColors.text2,
                    fontSize: isTablet ? 30 : 25,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 14,
          child: buildCards(),
        ),
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
          List<TaleModel?> data = [];
          data = snapshot.data!;
          numOfTales = data.length;
          for (int i = 0; i < numOfTales; i++) {
            _widgetKeyList = List.generate(
                numOfTales, (index) => GlobalObjectKey(index));
          }
          // If the device is a tablet and in landscape mode, make the SingleChildScrollView scroll horizontally and change the Column to a Row
          if (isTablet && isLandscape) {
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
        if (snapshot.hasData) {
          List<TaleModel?> data = [];
          // print("###########");
          data = snapshot.data!;
          numOfTales = data.length;
          print(numOfTales);
          for (int i = 0; i < numOfTales; i++) {
            _widgetKeyList.add(GlobalObjectKey<FormState>(i + data[i]!.id!.codeUnits.fold<int>(
                0, (previousValue, element) => previousValue * 256 + element)));
          }
          Set<GlobalKey<State<StatefulWidget>>> uniqueSet = Set.from(_widgetKeyList);
          _widgetKeyList = uniqueSet.toList();

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
}
