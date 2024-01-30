import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/models/tale_model.dart';
import 'package:trip_tales/src/services/tale_service.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/tale_card.dart';
import '../utils/app_manager.dart';
import '../utils/device_info.dart';

class FavoriteTalesPage extends StatefulWidget {
  @override
  _FavoriteTalesPage createState() => _FavoriteTalesPage();
}

class _FavoriteTalesPage extends State<FavoriteTalesPage> {
  final TaleService _taleService = Get.find<TaleService>();
  late Future<List<TaleModel?>> tales;
  late List<GlobalKey> _widgetKeyList;
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
    return Scaffold(
      //debugShowCheckedModeBanner: false,
      body: CustomAppBar(
        bodyTale: buildBody(),
        showIcon: false,
      ),
    );
    //  );
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          flex: 14,
          child: buildCards(),
        ),
      ],
    );
  }

  Widget buildCards() {
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
            _widgetKeyList = List.generate(
                numOfTales, (index) => GlobalObjectKey<FormState>(index));
          }
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
}
