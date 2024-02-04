import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trip_tales/src/constants/tale_background.dart';
import 'package:trip_tales/src/models/tale_model.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/services/tale_service.dart';
import 'package:trip_tales/src/widgets/canvas_card.dart';
import 'package:trip_tales/src/widgets/map.dart';
import '../constants/color.dart';
import '../constants/error_messages.dart';
import '../controllers/media_controller.dart';
import '../utils/app_manager.dart';
import '../utils/device_info.dart';
import '../utils/validator.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';
import '../widgets/app_bar_tale.dart';

class CreateTalePage extends StatefulWidget {
  final bool isEditMode;

  const CreateTalePage({super.key, this.isEditMode = false});

  @override
  _CreateTalePage createState() => _CreateTalePage();
}

class _CreateTalePage extends State<CreateTalePage> {
  late final TextEditingController _taleNameController;
  final MediaController mediaController = Get.put(MediaController());
  final TaleService _taleService = Get.find<TaleService>();
  final AppManager _appManager = Get.put(AppManager());
  final SetPhotoScreen setPhotoScreen = SetPhotoScreen();
  final Validator _validator = Validator();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TaleModel taleModel;
  int selectedIndex = 0;

  void _submit() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    print(selectedIndex.toString());

    File? imageFile = mediaController.getImage();
    TaleModel taleData = TaleModel(
      name: _taleNameController.text,
      imagePath: '${_taleNameController.text}_TALE.png',
      canvas: selectedIndex.toString(),
    );
    int result = 400;
    if (imageFile != null) {
      if (widget.isEditMode) {
        var currentTaleId = await _taleService.getTaleId(taleData.name);
        var currentTale = await _taleService
            .getTaleById(currentTaleId)
            .then((value) => taleData = TaleModel(
                  id: value!.id,
                  name: _taleNameController.text,
                  imagePath: '${value!.id}_TALE.png',
                  canvas: selectedIndex.toString(),
                  cardsFK: value!.cardsFK,
                ));

        result = await _taleService.updateTale(taleData, imageFile!);
      } else {
        result = await _taleService.addTale(taleData, imageFile!);
        var currentTaleId = await _taleService.getTaleId(taleData.name);
        var currentTale = await _taleService.getTaleById(currentTaleId);
        taleData = TaleModel(
          id: currentTale!.id ?? '',
          name: _taleNameController.text,
          imagePath: '${currentTale!.id}_TALE.png',
          canvas: selectedIndex.toString() ?? '0',
          cardsFK: List.empty(),
        );
        result = 200;
      }
    }
    if (result == 200) {
      _formKey.currentState?.save();
      var tale = await _taleService.getTaleById(taleData.id!);
      // print(")))))))))))))))))))))))))))))))))))))))))${taleData.id}");
      _appManager.setCurrentTale(tale!);
      if (widget.isEditMode) {
        Navigator.of(context).pushReplacementNamed('/talePage');
      } else {
        _appManager.setCurrentTaleId(taleData.id!);
        Navigator.of(context)
            .pushReplacementNamed('/talePage', result: 'createTalePage');
      }

      // if (widget.isEditMode) {
      //   Navigator.of(context).pop();
      // } else {
      // }
    } else {
      ErrorController.showSnackBarError(ErrorController.createTale);
      return;
    }
  }

  @override
  void initState() {
    _taleNameController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    if (widget.isEditMode) {
      taleModel = _appManager.getCurrentTale();
      _taleNameController.text = taleModel.name;
      // print(")))))))))))))))))))))))))))))))))))))))))${taleModel.imagePath}");
      mediaController.setImage(File(taleModel.imagePath));
      selectedIndex = int.parse(taleModel.canvas);
    } else {
      _appManager.resetTale();
      mediaController.setImage(null);
    }
    super.initState();
  }

  @override
  void dispose() {
    _taleNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return Scaffold(
      body: CustomAppBar(
        bodyTale: buildBody(),
        showIcon: true,
        navigationPath: '/pop',
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 320,
              child: SetPhotoScreen(
                isImage: true,
                imagePath: widget.isEditMode ? taleModel.imagePath : '',
                hasImage: widget.isEditMode,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 60,
              width: 330,
              child: CustomTextField(
                key: const Key('taleNameCustomTextFieldKey'),
                controller: _taleNameController,
                labelText: 'Tale Name',
                hintText: 'Enter your Tale Name',
                prefixIcon: Icons.abc,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: _validator.nameValidator,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //SizedBox(
            // height: 305,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    '  Choose your canvas:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.main1,
                      fontSize: 20,
                    ),
                  ),
                  buildCanvasList(),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: CustomButton(
                key: const Key('startCreatingCustomButtonKey'),
                fontSize: 18,
                padding: 2,
                backgroundColor: AppColors.main2,
                textColor: Colors.white,
                text: widget.isEditMode ? "Finish Editing" : "Start Creating",
                onPressed: _submit,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCanvasList() {
    return SizedBox(
      height: 280,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < TaleBackground.totalNum; i++)
              CustomCanvas(
                talePath: TaleBackground.paths[i],
                taleName: TaleBackground.names[i],
                onTap: () {
                  setState(() {
                    selectedIndex = i; // Mark this item as selected
                  });
                },
                isSelected:
                    selectedIndex == i, // Check if this item is selected
              ),
          ],
        ),
      ),
    );
  }
}
