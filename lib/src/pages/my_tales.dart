import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/models/tale_model.dart';
import 'package:trip_tales/src/services/tale_service.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/tale_card.dart';
import '../utils/device_info.dart';

class MyTalesPage extends StatefulWidget {
  @override
  _MyTalesPage createState() => _MyTalesPage();
}

class _MyTalesPage extends State<MyTalesPage> {
  final TaleService _taleService = Get.find<TaleService>();
  late Future<List<TaleModel?>> tales;
  late List<GlobalKey> _widgetKeyList;

  static int numOfTales = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      tales = _taleService.getTales("1");
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
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/createTalePage');
          },
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.main2,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        offset: Offset(-5, 5))
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
        ),
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
