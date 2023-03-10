import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monthly_alarm_app/provider/alarm_detail_viewmodel.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 1),
      child: Material(
        elevation: widget.isOn ? 3.0 : 0.0,
        borderRadius: BorderRadius.circular(22),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              color: widget.isOn
                  ? AppTheme.inputFieldLight
                  : AppTheme.transparent,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '',
                      style: TextStyle(fontSize: 12, color: AppTheme.defaultTextLight),
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: widget.isOn
                                        ? AppTheme.defaultBlueLight
                                        : AppTheme.transparent,
                                    border: Border.all(
                                        color: widget.isOn
                                            ? AppTheme.defaultBlueLight
                                            : AppTheme.disabledLight1)),
                                child: widget.isOn
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12,
                                      )
                                    : SizedBox.shrink()),
                          ),
                        ),
                        WidgetSpan(child: AutoSizeText(widget.title,maxFontSize: 15,style: TextStyle(color: widget.isOn ?AppTheme.defaultTextLight
                            :AppTheme.defaultGreyLight2),)),
                      ],
                    ),
                  ),
                  if (widget.isOn && widget.isCustom)
                    AutoSizeText(
                      '매월 ${widget.day}일',
                      style: TextStyle(color: AppTheme.defaultBlueLight),
                      maxFontSize: 12,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
