import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/color.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Color labelTextColor;
  final String? hintText;
  final Color? hintTextColor;
  final int maxLines;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final bool isPassword;
  final bool isEditableOnOtherWindow;
  late final bool isPasswordVisible;
  final VoidCallback? onVisibilityPressed;
  final bool obscureText;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool enabled;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final bool autocorrect;
  final bool enableSuggestions;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final List<TextInputFormatter>? inputFormatters;
  final Color focusedColor;
  final Color enabledColor;
  final Color fillColor;
  final bool filled;
  final Color iconColor;
  final Color textColor;
  final double fontSize;
  final FontStyle fontStyle;
  final bool isFieldColor;
  final bool isTablet; //added for the tablet version

  CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.labelTextColor = AppColors.text3,
    this.hintTextColor = AppColors.text3,
    this.maxLines = 1,
    this.prefixIcon = Icons.person,
    this.suffixIcon = Icons.visibility_off,
    this.isPassword = false,
    this.isEditableOnOtherWindow = false,
    this.isPasswordVisible = false,
    this.onVisibilityPressed,
    this.obscureText = false,
    this.readOnly = false,
    this.validator,
    this.onChanged,
    this.onTap,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.border,
    this.focusedBorder,
    this.inputFormatters,
    this.focusedColor = AppColors.main1,
    this.enabledColor = AppColors.main1,
    this.fillColor = AppColors.main1,
    this.iconColor = AppColors.main1,
    this.filled = false,
    this.textColor = AppColors.text1,
    this.fontSize = 16,
    this.fontStyle = FontStyle.normal,
    this.isFieldColor = false,
    this.isTablet = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.isTablet ? 400 : 300,
        height: widget.isTablet ? 70 : 40,
        child: TextFormField(
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: widget.textColor,
            fontSize: widget.fontSize,
            fontStyle: widget.fontStyle,
          ),
          controller: widget.controller,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          cursorColor: widget.focusedColor,
          autocorrect: widget.autocorrect,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          enableSuggestions: widget.enableSuggestions,
          decoration: InputDecoration(
            labelText: widget.labelText,
            contentPadding:
                EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            filled: widget.filled,
            fillColor: widget.fillColor,
            labelStyle: TextStyle(color: widget.labelTextColor),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: widget.hintTextColor),
            prefixIcon: Icon(widget.prefixIcon,
                color: widget.iconColor,
                shadows: widget.isFieldColor
                    ? [const Shadow(color: Colors.grey, offset: Offset(-2, 2))]
                    : null),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(widget.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    color: AppColors.main1,
                    onPressed: widget.onVisibilityPressed,
                  )
                : widget.isEditableOnOtherWindow
                    ? IconButton(
                        icon: Icon(widget.suffixIcon),
                        color: AppColors.main1,
                        onPressed: widget.onVisibilityPressed,
                      )
                    : null,
            errorStyle: const TextStyle(
              fontSize: 10.0,
              height: 0.4,
            ),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(25.0),
            //   borderSide: BorderSide(
            //     color: Colors.blue,
            //   ),
            // ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: widget.enabledColor,
              ),
              gapPadding: 5,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: widget.focusedColor,
              ),
              gapPadding: 5,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: widget.enabledColor,
              ),
              gapPadding: 5,
            ),
          ),
          validator: widget.validator,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          inputFormatters: widget.inputFormatters,
        ));
  }
}
