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
    return Material(
      elevation: 2,
      shadowColor: AppTheme.backgroundBlue,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
              color: AppTheme.white,
            //borderRadius: BorderRadius.circular(22)
          ),
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    widget.title,
                    style: AppTheme.body1.apply(color: widget.isOn ? AppTheme.defaultBlue : AppTheme.defaultGrey,),
                  ),
                ),
              ),
              Icon(
                Icons.check,
                color: widget.isOn ? AppTheme.defaultBlue : AppTheme.defaultGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
