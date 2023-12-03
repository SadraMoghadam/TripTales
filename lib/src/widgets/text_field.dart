import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final IconData prefixIcon;
  final bool isPassword;
  late final bool isPasswordVisible;
  final VoidCallback? onVisibilityPressed;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
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
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.border,
    this.focusedBorder,
    this.inputFormatters,
    this.focusedColor = Colors.deepPurple,
    this.enabledColor = Colors.deepPurple,
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
          enableSuggestions: widget.enableSuggestions,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyle(color: Colors.grey),
            hintText: widget.hintText,
            prefixIcon: Icon(widget.prefixIcon, color: Colors.deepPurple),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(widget.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    color: Colors.deepPurple,
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
          inputFormatters: widget.inputFormatters,
        ));
  }
}
