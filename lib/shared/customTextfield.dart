// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final Function? onChanged;
  final TextEditingController controller;
  final String? errorText;
  final bool? obscureText;
  final bool? isEnabled;

  // ignore: use_key_in_widget_constructors
  const CustomTextField(
      {required this.hintText,
      required this.labelText,
      this.onChanged,
      required this.controller,
      this.errorText,
      this.obscureText,
      this.isEnabled});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ScreenUtil _screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    Color textPaint = Color(0xFFB14181c);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.only(top: 5.0),
        width: MediaQuery.of(context).size.width >= 1200
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.width / 1.1,
        child: TextFormField(
          onChanged: (text) {
            if (widget.onChanged != null) {
              widget.onChanged!(text);
            }
          },
          controller: widget.controller,
          style: TextStyle(color: Colors.black),
          enabled: widget.isEnabled,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey),
            labelText: widget.labelText,
            labelStyle: TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              width: 2.5,
              color: Color.fromARGB(255, 14, 140, 172),
            )),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              width: 2,
              color: Colors.grey,
            )),
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2)),
            errorText: widget.errorText,
          ),
          obscureText: widget.obscureText == null ? false : true,
          obscuringCharacter: '*',
        ),
      ),
    );
  }
}
