import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/color.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final IconData prefixIcon;
  final bool isPassword;
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

  CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.prefixIcon = Icons.person,
    this.isPassword = false,
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
    this.focusedColor = cmain1,
    this.enabledColor = cmain1,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          cursorColor: widget.focusedColor,
          autocorrect: widget.autocorrect,
          readOnly: widget.readOnly,
          enableSuggestions: widget.enableSuggestions,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyle(color: ctext3),
            hintText: widget.hintText,
            prefixIcon: Icon(widget.prefixIcon, color: cmain1),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(widget.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    color: cmain1,
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
          onTap: widget.readOnly ? widget.onTap : null,
          inputFormatters: widget.inputFormatters,
        ));
  }
}
