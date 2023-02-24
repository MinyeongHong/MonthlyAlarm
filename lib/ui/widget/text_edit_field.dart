import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monthly_alarm_app/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;

  const CustomTextField({Key? key, this.hintText, required this.controller}) : super(key: key);

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
          print(text);
          if(text.isNotEmpty) isEmpty=false;

        },
        controller: widget.controller,
        decoration: InputDecoration(
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

// class CustomTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final String hintText;
//
//   const CustomTextField(
//       {Key? key, required this.controller, required this.hintText})
//       : super(key: key);
//
//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }
//
// class _CustomTextFieldState extends State<CustomTextField> {
//   late final TextEditingController textController;
//
//   @override
//   void initState() {
//     super.initState();
//     textController = widget.controller;
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       borderRadius: BorderRadius.circular(42),
//       elevation: 5,
//       shadowColor: AppTheme.backgroundBlue,
//       child: TextFormField(
//         controller: textController,
//         decoration: InputDecoration(
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(42),
//                 borderSide: const BorderSide(width: 0.0, color: Colors.transparent)),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(42),
//                 borderSide: const BorderSide(width: 0.0, color: Colors.transparent)),
//             hintText: widget.hintText,
//             hintStyle: AppTheme.body1.apply(color: AppTheme.defaultGrey),
//             fillColor: AppTheme.white,
//             filled: true,
//             suffixIcon: textController.text.isNotEmpty
//                 ? IconButton(
//                     icon: const Icon(
//                       Icons.cancel,
//                       color: AppTheme.defaultGrey,
//                     ),
//                     onPressed: () {
//                       textController.clear();
//                     },
//                   )
//                 : const SizedBox.shrink()),
//       ),
//     );
//   }
// }
