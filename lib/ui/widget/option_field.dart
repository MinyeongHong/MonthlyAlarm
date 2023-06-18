import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
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
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AutoSizeText(
                widget.title,
                maxFontSize: 14,
                style: Theme.of(context).textTheme.titleSmall!.apply(color: widget.isOn ? AppTheme.defaultBlueLight : AppTheme.disabledLight2),
              ),
            ),
            Icon(
              CupertinoIcons.checkmark_alt,
              color: widget.isOn ? AppTheme.defaultBlueLight : AppTheme.disabledLight2,
            ),
          ],
        ),
      ),
    );
  }
}
