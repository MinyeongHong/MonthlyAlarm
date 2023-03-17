import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:monthly_alarm_app/provider/alarm_detail_viewmodel.dart';

import '../../app_theme.dart';

class CustomRadioButton extends StatefulWidget {
  final ThemeData theme;
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
    required this.theme,
  }) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 1),
      child: widget.theme.brightness == Brightness.dark
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                boxShadow: widget.isOn
                    ? const [
                        BoxShadow(color: Color(0xFF414F5E)),
                        BoxShadow(
                            color: AppTheme.inputFieldDark,
                            spreadRadius: -2.0,
                            blurRadius: 3.0,
                            offset: Offset(-1, 3)),
                      ]
                    : [],
              ),
              child: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    color: widget.isOn
                        ? AppTheme.transparent
                        : widget.theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, bottom: 2),
                                  child: Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: widget.isOn
                                              ? widget.theme.primaryColor
                                              : widget.theme
                                                  .scaffoldBackgroundColor,
                                          border: Border.all(
                                            color: widget.isOn
                                                ? widget.theme.primaryColor
                                                : widget.theme.disabledColor,
                                          )),
                                      child: widget.isOn
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 12,
                                            )
                                          : SizedBox.shrink()),
                                ),
                              ),
                              WidgetSpan(
                                  child: AutoSizeText(
                                widget.title,
                                maxFontSize: 15,
                                style: TextStyle(
                                    color: widget.isOn
                                        ? widget.theme
                                            .textTheme
                                            .bodyLarge!
                                            .color
                                        : widget.theme
                                            .inputDecorationTheme
                                            .hintStyle!
                                            .color),
                              )),
                            ],
                          ),
                        ),
                        if (widget.isOn && widget.isCustom)
                          AutoSizeText(
              "EveryCustom".tr(args:[widget.day.toString()]),
                            style: TextStyle(color: widget.theme.primaryColor),
                            maxFontSize: 12,
                          ),
                        SizedBox(width: 5,)
                      ],
                    ),
                  ),
                ),
              ))
          : Material(
              color: widget.isOn
                  ? widget.theme.inputDecorationTheme.fillColor
                  : widget.theme.backgroundColor,
              elevation: widget.isOn ? 3.0 : 0.0,
              borderRadius: BorderRadius.circular(22),
              child: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    color: widget.isOn
                        ? widget.theme.inputDecorationTheme.fillColor
                        : widget.theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '',
                            style: TextStyle(
                              fontSize: 12,
                            ),
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
                                              ? widget.theme.primaryColor
                                              : widget.theme
                                                  .scaffoldBackgroundColor,
                                          border: Border.all(
                                            color: widget.isOn
                                                ? widget.theme.primaryColor
                                                : widget.theme.disabledColor,
                                          )),
                                      child: widget.isOn
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 12,
                                            )
                                          : SizedBox.shrink()),
                                ),
                              ),
                              WidgetSpan(
                                  child: AutoSizeText(
                                widget.title,
                                maxFontSize: 15,
                                style: TextStyle(
                                    color: widget.theme.brightness ==
                                            Brightness.dark
                                        ? widget.isOn
                                            ? AppTheme.defaultTextDark
                                            : AppTheme.defaultGreyDark2
                                        : widget.isOn
                                            ? AppTheme.defaultTextLight
                                            : AppTheme.defaultGreyLight2),
                              )),
                            ],
                          ),
                        ),
                        if (widget.isOn && widget.isCustom)
                          AutoSizeText(
                            "EveryCustom".tr(args:[widget.day.toString()]),
                            style: TextStyle(color: widget.theme.primaryColor),
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
