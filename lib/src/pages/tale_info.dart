import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trip_tales/src/constants/tale_background.dart';
import 'package:trip_tales/src/models/tale_model.dart';
import 'package:trip_tales/src/pages/create_tale_page.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/services/tale_service.dart';
import 'package:trip_tales/src/utils/tuple.dart';
import 'package:trip_tales/src/widgets/canvas_card.dart';
import 'package:trip_tales/src/widgets/map.dart';
import '../constants/color.dart';
import '../constants/error_messages.dart';
import '../controllers/media_controller.dart';
import '../utils/app_manager.dart';
import '../utils/device_info.dart';
import '../utils/validator.dart';
import '../widgets/button.dart';
import '../widgets/delete_item_dialog.dart';
import '../widgets/text_field.dart';
import '../widgets/app_bar_tale.dart';

class TaleInfoPage extends StatefulWidget {
  @override
  _TaleInfoPage createState() => _TaleInfoPage();
}

class _TaleInfoPage extends State<TaleInfoPage> {
  final TaleService _taleService = Get.find<TaleService>();
  final AppManager _appManager = Get.put(AppManager());
  final SetPhotoScreen setPhotoScreen = SetPhotoScreen();
  TaleModel? _currentTale;
  late List<Tuple<String, LatLng>>? _mapLocations;
  Set<Marker> _markers = HashSet<Marker>();
  GoogleMapController? _mapController;
  int selectedIndex = 0;
  var imagePath = '';

  // late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _currentTale = _appManager.getCurrentTale();
    _mapLocations = _appManager.getCurrentTaleLocations();
    _loadImageData();
    print("-_-_-_--_---_--_-_---$_mapLocations");
    for (int i = 0; i < _mapLocations!.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(_mapLocations![i]!.toString()),
        position: _mapLocations![i]!.item2,
        infoWindow: InfoWindow(
          title: _mapLocations![i]!.item1,
          snippet:
              'The location where this memory ("${_mapLocations![i]!.item1}") was made',
        ),
      ));
    }
    // _controller =
    //     AnimationController(vsync: this, duration: Duration(seconds: 4));
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  void _loadImageData() {
    setState(() {
      imagePath = _currentTale!.imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: CustomAppBar(
        bodyTale: buildBody(),
        showIcon: true,
        isScrollable: false,
        navigationPath: '/pop',
      ),
    );
  }

  Widget buildBody() {
    return Container(
      color: AppColors.main1.shade300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Text(
              _currentTale!.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 7,
            child: Container(
              height: 200,
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.main2, width: 5),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  '$imagePath?timestamp=${DateTime.now().millisecondsSinceEpoch}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: SizedBox(
                height: 10,
              )),
          Flexible(
            fit: FlexFit.tight,
            flex: 7,
            child: buildGoogleMap(),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 150,
                  child: CustomButton(
                    // key: const Key('editTaleCustomButtonKey'),
                    fontSize: 18,
                    padding: 2,
                    backgroundColor: AppColors.main2,
                    textColor: Colors.white,
                    text: "Edit",
                    onPressed: _onEditButtonClick,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: CustomButton(
                    // key: const Key('deleteTaleCustomButtonKey'),
                    fontSize: 18,
                    padding: 2,
                    backgroundColor: AppColors.main3,
                    textColor: Colors.white,
                    text: "Delete",
                    onPressed: _onDeleteButtonClick,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onEditButtonClick() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateTalePage(
                isEditMode: true,
              )),
    );
    // if(result) {
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         _controller.reset();
    //         _controller.forward();
    //         return AlertDialog(
    //           content: Lottie.asset(
    //             "assets/animations/loading.json",
    //             width: 400,
    //             height: 400,
    //             controller: _controller,
    //           ),
    //         );
    //       });
    //   Future.delayed(Duration(seconds: 3), () {
    //     print("hiii");
    //     Navigator.of(context).pop();
    //     refreshPage();
    //   });
    // }
  }

  void _onDeleteButtonClick() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeleteItemDialog(
            name: _currentTale!.name,
            isTale: true,
          );
        }).then((value) => setState(() {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/customMenu', (route) => route.isFirst);
        }));
  }

  Widget buildGoogleMap() {
    print(_markers);
    return Container(
      height: 350,
      width: 350,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.main2, width: 5),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          height: 400,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: _mapLocations!.length == 0
                ? const CameraPosition(
                    target: LatLng(37.7749, -122.4194),
                    zoom: 12,
                  )
                : CameraPosition(
                    target: _markers!.first.position,
                    zoom: 12,
                  ),
            onTap: _onMapTap,
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void _onMapTap(LatLng tappedPoint) {
    showDialog(
      context: context,
      builder: (context) {
        return MapScreen(
          isReadonly: true,
          markers: _markers,
        );
      },
    );
  }
}
