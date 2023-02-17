import 'package:flutter/material.dart';
import 'package:monthly_alarm_app/app_theme.dart';

class OptionField extends StatefulWidget {
  final String title;
  final Function() onTap;
  final bool isOn;

  const OptionField(
      {Key? key, required this.title, required this.onTap, required this.isOn})
      : super(key: key);

  @override
  State<OptionField> createState() => _OptionFieldState();
}

class _OptionFieldState extends State<OptionField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        color: AppTheme.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 19),
                ),
              ),
            ),
            Icon(
              Icons.check,
              color: widget.isOn ? AppTheme.blue : AppTheme.selectedGrey,
            ),
          ],
        ),
      ),
    );
  }
}
