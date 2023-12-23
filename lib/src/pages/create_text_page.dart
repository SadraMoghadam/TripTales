import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/utils/text_utils.dart';
import 'package:trip_tales/src/utils/validator.dart';
import '../constants/color.dart';
import '../constants/error_messages.dart';
import '../constants/memory_card_type.dart';
import '../models/card_model.dart';
import '../services/card_service.dart';
import '../utils/device_info.dart';
import '../utils/password_strength_indicator.dart';
import '../widgets/button.dart';
import '../widgets/dropdown_button.dart';
import '../widgets/text_field.dart';

class CreateTextPage extends StatefulWidget {
  @override
  _CreateTextPageState createState() => _CreateTextPageState();
}

class _CreateTextPageState extends State<CreateTextPage> {
  final Validator _validator = Validator();
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _textController;
  late final TextEditingController _colorController;
  late final TextEditingController _backgroundColorController;
  double _fontSize = 16;
  Color _selectedColor = AppColors.main2;
  Color _selectedBackgroundColor = Color.fromRGBO(0, 0, 0, 0);
  List<String> textDecorationOptions = const [
    'None',
    'Underline',
    'Line through',
    "Overline"
  ];
  String _selectedTextDecoration = 'None';
  List<String> fontStyleOptions = const ['Normal', 'Italic'];
  String _selectedFontStyle = 'Normal';
  List<String> fontWeightOptions = const [
    'XSmall',
    'Small',
    'Medium',
    'Large',
    'XLarge'
  ];
  String _selectedFontWeight = 'Medium';

  final CardService _cardService = Get.find<CardService>();

  // late final TextEditingController _passwordController;

  void _handletextDecorationValueChanged(String? newValue) {
    _selectedTextDecoration = newValue!;
  }
  void _handleFontStyleValueChanged(String? newValue) {
    _selectedFontStyle = newValue!;
  }
  void _handleFontWeightValueChanged(String? newValue) {
    _selectedFontWeight = newValue!;
  }

  void _submit() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    CardModel textCardData = CardModel(
      id: "1",
      order: 1,
      type: MemoryCardType.text,
      transform: Matrix4.identity(),
      name: _nameController.text,
      text: _textController.text,
      textColor: _selectedColor,
      textBackgroundColor: _selectedBackgroundColor,
      textDecoration: TextUtils.textToDecoration(_selectedTextDecoration),
      fontStyle: TextUtils.textToFontStyle(_selectedFontStyle),
      fontWeight: TextUtils.textToFontWeight(_selectedFontWeight),
      fontSize: _fontSize,
    );
    int result = await _cardService.addTextCard(textCardData);
    if (result == 200) {
      _formKey.currentState?.save();
      Navigator.of(context).pop(true);
    } else {
      ErrorController.showSnackBarError(ErrorController.createImage);
      return;
    }
  }

  void _showColorPicker(bool isColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: isColor ? _selectedColor : _selectedBackgroundColor,
              onColorChanged: (color) {
                setState(() {
                  if (isColor) {
                    _selectedColor = color;
                  } else {
                    _selectedBackgroundColor = color;
                  }
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _nameController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _textController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _colorController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _backgroundColorController = TextEditingController()
      ..addListener(() {
        setState(() {});
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
    return AlertDialog(
      elevation: 10,
      shadowColor: Colors.grey,
      title: const Center(
          child: Text(
        'Add new text',
        style: TextStyle(
            color: AppColors.main1, fontSize: 25, fontWeight: FontWeight.w700),
      )),
      insetPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: buildBody(device),
      actions: <Widget>[
        CustomButton(
            height: 5,
            width: 30,
            fontSize: 12,
            backgroundColor: AppColors.main3,
            text: "close",
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop())
      ],
    );
  }

  Widget buildBody(DeviceInfo device) {
    return SingleChildScrollView(
      child: Container(
        height: device.height - 240,
        width: device.width,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Center(
                    child: CustomTextField(
                      controller: _nameController,
                      labelText: 'Text name',
                      hintText: 'Enter your text name',
                      prefixIcon: Icons.abc,
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: _validator.nameValidator,
                    ),
                  )),
              Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Center(
                    child: CustomTextField(
                      controller: _textController,
                      labelText: 'Text',
                      hintText: 'Enter your text',
                      prefixIcon: Icons.text_snippet_rounded,
                      obscureText: false,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      validator: _validator.nameValidator,
                    ),
                  )),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Center(
                  child: CustomTextField(
                    controller: _colorController,
                    isFieldColor: true,
                    labelText: 'Text color',
                    hintText: 'Text color',
                    // labelTextColor: _selectedColor,
                    // hintTextColor: _selectedColor,
                    readOnly: true,
                    iconColor: _selectedColor,
                    onTap: () => _showColorPicker(true),
                    prefixIcon: Icons.color_lens,
                    obscureText: false,
                    keyboardType: TextInputType.none,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Center(
                  child: CustomTextField(
                    controller: _backgroundColorController,
                    isFieldColor: true,
                    labelText: 'Background color',
                    hintText: 'Background color',
                    // labelTextColor: _selectedBackgroundColor,
                    // hintTextColor: _selectedBackgroundColor,
                    readOnly: true,
                    iconColor: _selectedBackgroundColor,
                    onTap: () => _showColorPicker(false),
                    prefixIcon: Icons.color_lens,
                    obscureText: false,
                    keyboardType: TextInputType.none,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Center(
                  child: CustomDropdownButton(
                    selectedValue: _selectedTextDecoration,
                    label: 'Text Decoration',
                    items: textDecorationOptions,
                    onValueChanged: _handletextDecorationValueChanged,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Center(
                  child: CustomDropdownButton(
                    selectedValue: _selectedFontStyle,
                    label: 'Font style',
                    items: fontStyleOptions,
                    onValueChanged: _handleFontStyleValueChanged,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Center(
                  child: CustomDropdownButton(
                    selectedValue: _selectedFontWeight,
                    label: 'Font weight',
                    items: fontWeightOptions,
                    onValueChanged: _handleFontWeightValueChanged,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Center(
                  child: Container(
                      width: 320,
                      height: 60,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          const Text("Font size",
                              style: TextStyle(
                                  color: AppColors.text1,
                                  decoration: TextDecoration.underline)),
                          SliderTheme(
                            data: SliderThemeData(
                              thumbColor: AppColors.main1,
                              trackHeight: 10,
                              trackShape: RoundedRectSliderTrackShape(),
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 10, pressedElevation: 10),
                              inactiveTrackColor: AppColors.main1.shade100,
                              activeTrackColor: AppColors.main1,
                              overlayColor: AppColors.main1.shade200,
                              overlayShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 11, pressedElevation: 11),
                            ),
                            child: Slider(
                              // thumbColor: AppColors.main1,
                              // activeColor: AppColors.main1,
                              // inactiveColor: AppColors.main1.shade100,
                              value: _fontSize,
                              min: 10,
                              max: 100,
                              divisions: 100 - 10,
                              label: _fontSize.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _fontSize = value;
                                });
                              },
                            ),
                          )
                        ],
                      )
                      //   child: CustomTextField(
                      //     controller: _fontSizeController,
                      //     labelText: 'Font size',
                      //     hintText: 'Enter the font size',
                      //     prefixIcon: Icons.format_size,
                      //     obscureText: false,
                      //     keyboardType: TextInputType.number,
                      //     textInputAction: TextInputAction.next,
                      //     validator: _validator.nameValidator,
                      //   ),
                      // )
                      ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Center(
                    child: CustomButton(
                        height: 20,
                        width: 200,
                        text: "Submit",
                        textColor: Colors.white,
                        onPressed: () => _submit())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
