import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monthly_alarm_app/app_theme.dart';



class CustomTextField extends ConsumerStatefulWidget {
  final String? hintText;
  final TextEditingController controller;

  const CustomTextField({Key? key, this.hintText, required this.controller})
      : super(key: key);

  @override
  ConsumerState<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  final isEmptyProvider = StateProvider<bool>((ref) => true);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: (text) {
          if (text.isEmpty) {
            ref.read(isEmptyProvider.notifier).state = true;
          } else {
            ref.read(isEmptyProvider.notifier).state = false;
          }
        },
        controller: widget.controller,
        decoration: InputDecoration(
          fillColor: AppTheme.transparent,
          //  fillColor: AppTheme.inputFieldDark,
            hintText: widget.hintText,
            suffixIcon: !ref.watch(isEmptyProvider)
                ? IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: AppTheme.defaultGreyLight1,
                    ),
                    onPressed: () {
                      widget.controller.clear();
                      ref.read(isEmptyProvider.notifier).state = true;
                    },
                  )
                : const SizedBox.shrink()),

    );
  }
}
