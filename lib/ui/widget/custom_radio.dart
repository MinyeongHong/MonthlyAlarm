import 'package:flutter/material.dart';
import 'package:monthly_alarm_app/provider/alarm_detail_provider.dart';

import '../../app_theme.dart';

class CustomRadioButton extends StatefulWidget {
  final String title;
  final Function() onTap;
  final bool isOn;
  final bool isCustom;
  final int? day;

  const CustomRadioButton({
    Key? key,
    required this.title,
    required this.onTap,
    required this.isOn,
    required this.isCustom,
    this.day,
  }) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            color:
                widget.isOn ? AppTheme.transParentBlue : AppTheme.backgroundGrey,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.isOn ? AppTheme.blue : Colors.transparent,
                        border: Border.all(
                            color: widget.isOn
                                ? AppTheme.blue
                                : AppTheme.disableGrey)),
                    child: widget.isOn
                        ? Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 13,
                            ),
                          )
                        : SizedBox.shrink()),
              ),
              Text(
                widget.title,
                style: AppTheme.body1,
              ),
              Spacer(),
              if (widget.isOn && widget.isCustom)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    '매월 ${widget.day}일',
                    style: TextStyle(color: AppTheme.blue),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
