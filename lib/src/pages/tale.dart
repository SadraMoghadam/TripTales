import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/constants/tale_background.dart';
import 'package:trip_tales/src/models/tale_model.dart';
import 'package:trip_tales/src/pages/reorder_page.dart';
import 'package:trip_tales/src/pages/tale_info.dart';
import 'package:trip_tales/src/services/tale_service.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/button_slider.dart';
import 'package:trip_tales/src/widgets/dialog_popup.dart';
import '../services/card_service.dart';
import '../utils/app_manager.dart';
import '../utils/device_info.dart';
import '../widgets/tale_builder.dart';

class TalePage extends StatefulWidget {
  const TalePage({super.key});

  @override
  State<TalePage> createState() => _TalePageState();
}

class _TalePageState extends State<TalePage> with TickerProviderStateMixin {
  bool reload = false;

  bool isInit = false;
  bool isEditMode = false;
  Key _contentKey = UniqueKey();
  late Completer<void> flagCompleter;
  final CardService _cardService = Get.find<CardService>();
  final TaleService _taleService = Get.find<TaleService>();
  final AppManager _appManager = Get.put(AppManager());
  final String canvas = 'assets/images/background_tale.jpg';
  late Future<TaleModel?> taleModel;
  DeviceInfo device = DeviceInfo();

  callback() {
    setState(() {
      reload = true;
      _contentKey = UniqueKey();
    });
  }

  @override
  void initState() {
    taleModel = _taleService.getTaleById(_appManager.getCurrentTaleId());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //
  //   String? result = ModalRoute.of(context)!.settings.arguments as String?;
  //   taleModel = _taleService.getTaleById(_appManager.getCurrentTaleId());
  //
  //   if (result == 'createTalePage' && !isInit) {
  //     _controller = AnimationController(vsync: this, duration: Duration(seconds: 4));
  //     showDialog(
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
  //       },
  //     );
  //
  //     Future.delayed(Duration(seconds: 3), () {
  //       print("hiii");
  //       Navigator.of(context).pop();
  //       setState(() {
  //         this.isInit = true;
  //       });
  //     });
  //   }
  // }

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
    device.computeDeviceInfo(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomAppBar(
          bodyTale: buildBody(),
          showIcon: true,
          isScrollable: !isEditMode,
          navigationPath: '/customMenu',
        ));
  }

  Widget buildBody() {
    return FutureBuilder(
        future: taleModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return CircularProgressIndicator();
            return Container();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final decorationImage = DecorationImage(
              image: AssetImage(
                  TaleBackground.paths[int.parse(snapshot.data!.canvas)]),
              fit: BoxFit.cover,
              opacity: 0.3,
            );
            return Container(
              decoration: BoxDecoration(image: decorationImage),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    // physics: isEditMode ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
                    // physics: isEditMode ? const FixedExtentScrollPhysics() : const AlwaysScrollableScrollPhysics(),
                    physics: AlwaysScrollableScrollPhysics(),
                    child: TaleBuilder(
                        callback: callback,
                        isEditMode: isEditMode,
                        reload: reload,
                        taleKey: _contentKey),
                  ),
                  // TaleBuilder(callback: callback, isEditMode: isEditMode, reload: reload, taleKey: _contentKey),
                  // ListView.builder(
                  //   itemCount: 20,
                  //   itemBuilder: (context, index) {
                  //     return TaleBuilder(
                  //               callback: callback,
                  //               isEditMode: isEditMode,
                  //               reload: reload,
                  //               taleKey: _contentKey
                  //         );
                  //   },
                  // ),
                  isEditMode ? buildAddMemory() : Container(),
                  isEditMode ? buildReorder() : Container(),
                  isEditMode ? buildSave() : Container(),
                  buildEditModeButton(),
                  buildTaleInfo()
                ],
              ),
            );
          }
        });
  }

  Widget buildTaleInfo() {
    return Positioned(
        right: 0,
        top: (device.height - 100 - 70) / 2,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(_customPageRouteBuilder(TaleInfoPage()));
          },
          child: RotatedBox(
            quarterTurns: 3,
            // Rotate text 90 degrees counter-clockwise
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.main1,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black45,
                        blurRadius: 3,
                        spreadRadius: 3)
                  ],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              width: 100.0,
              height: 40.0,
              child: const Center(
                child: Text(
                  'Tale Info',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  PageRouteBuilder _customPageRouteBuilder(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
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
          _appManager.setIsCardsTransformChanged(false);
          if (isEditMode) {
            Timer(
              Duration(seconds: 0),
              () {
                setState(
                  () {
                    reload = true;
                    _contentKey = UniqueKey();
                    isEditMode = !isEditMode;
                  },
                );
              },
            );
          } else {
            setState(() {
              isEditMode = !isEditMode;
            });
          }
        },
        child: Container(
          width: 120,
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(color: Colors.black45, blurRadius: 3, spreadRadius: 3)
          ], borderRadius: BorderRadius.circular(30), color: AppColors.main2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: isEditMode ? AppColors.main2 : AppColors.main1),
                  child: Center(
                      child: Text(
                    'View',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isEditMode ? Colors.black : Colors.white),
                  )),
                ),
                Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: isEditMode ? AppColors.main3 : AppColors.main2),
                  child: Center(
                      child: Text(
                    'Edit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isEditMode ? Colors.white : Colors.black),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSave() {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    // bool a = _appManager.getIsCardsTransformChanged();
    return Positioned(
      bottom: 25,
      left: (device.width - 70) / 2,
      child: GestureDetector(
        onTap: () {
          onSaveButtonClick();
        },
        child: Container(
          width: 70,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(color: Colors.black45, blurRadius: 3, spreadRadius: 3)
          ], borderRadius: BorderRadius.circular(30), color: AppColors.main1),
          child: const Center(
            // child: Text(
            //   'Save',
            //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            // ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }

  void onSaveButtonClick() {
    if (_appManager.getIsCardsTransformChanged()) {
      String currentTale = _appManager.getCurrentTaleId();
      // var taleCards = await _cardService.getCards(currentTale);
      var cardsNewTransform = _appManager.getCardsTransform();
      var userCards = _appManager.getCards();
      if (cardsNewTransform != null) {
        int numOfCards = cardsNewTransform.length;
        for (int i = 0; i < numOfCards; i++) {
          // var translation = cardsNewTransform[i].item2.getTranslation();
          // cardsNewTransform[i].item2.setTranslationRaw(
          //     translation.x / device.width > 1 ? 1 : translation.x / device.width,
          //     translation.y,
          //     translation.z);
          // _appManager.setCardTransform(cardsNewTransform[i].item1, cardsNewTransform[i].item2);

          var card = userCards!.firstWhere((element) =>
          element!.name == cardsNewTransform[i].item1);
          card!.transform.setFrom(cardsNewTransform[i].item2);
          userCards![userCards!.indexOf(card)] = card;
          _cardService.updateCardTransform(currentTale,
              cardsNewTransform[i].item1, cardsNewTransform[i].item2);
        }
      }
      showSaveDialog();
      _appManager.clearCardTransform();
      _appManager.setIsCardsTransformChanged(false);
    }
  }

  void showSaveDialog() {
    if (_appManager.getIsCardsTransformChanged()) {
      DialogPopup(text: 'Cards positions are saved successfully', duration: 2)
          .show(context);
    }
  }

  Widget buildReorder() {
    return Positioned(
      bottom: 25,
      left: 20,
      child: GestureDetector(
        onTap: () {
          onReorderButtonClick();
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(color: Colors.black45, blurRadius: 3, spreadRadius: 3)
          ], borderRadius: BorderRadius.circular(30), color: AppColors.main2),
          child: const Center(
              child: Text(
            'Reorder',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
        }).then((value) => setState(() {
          callback();
        }));
    // if (result != null && result == true) {
    //   setState(() {
    //     callback();
    //   });
    // }
  }

  Widget buildAddMemory() {
    return ButtonSlider(
      callback: callback,
    );
  }
}
