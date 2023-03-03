import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monthly_alarm_app/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;

  const CustomTextField({Key? key, this.hintText,required this.controller}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    bool isEmpty =true;

    return Material(
      borderRadius: BorderRadius.circular(42),
      elevation: 5,
      shadowColor: AppTheme.backgroundBlue,
      child: TextFormField(
        onChanged: (text){
          if(text.isNotEmpty) isEmpty=false;
        },
        controller: widget.controller,
        decoration: InputDecoration(
          isDense: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(42),
                borderSide:
                const BorderSide(width: 0.0, color: Colors.transparent)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(42),
                borderSide:
                const BorderSide(width: 0.0, color: Colors.transparent)),
            hintText: widget.hintText,
            hintStyle: AppTheme.body1.apply(color: AppTheme.defaultGrey),
            fillColor: AppTheme.white,
            filled: true,
            suffixIcon: !isEmpty
                ? IconButton(
              icon: const Icon(
                Icons.cancel,
                color: AppTheme.defaultGrey,
              ),
              onPressed: () {
                widget.controller.clear();
              },
            )
                : const SizedBox.shrink()),
      ),
    );
  }
}