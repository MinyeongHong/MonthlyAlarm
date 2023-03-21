import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monthly_alarm_app/provider/alarm_detail_viewmodel.dart';
import 'package:intl/intl.dart';
import '../../app_theme.dart';

class TimePicker extends StatefulWidget {
  final AlarmDetailViewModel vm;
  final ThemeData theme;

  const TimePicker({Key? key, required this.vm, required this.theme})
      : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    return widget.theme.brightness == Brightness.dark
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              boxShadow: const [
                BoxShadow(color: Color(0xFF414F5E)),
                BoxShadow(
                    color: AppTheme.inputFieldDark,
                    spreadRadius: -2.0,
                    blurRadius: 3.0,
                    offset: Offset(-1, 3)),
              ],
            ),
            child:  GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: AppTheme.transparent,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.Hm().format(widget.vm.state.time!),
                        style: AppTheme.title2,
                      ),
                      _toggle()
                    ],
                  ),
                ),
              ),
              onTap: () {
                FocusScope.of(context).unfocus();
                _selectTime(context);
              },
            ),
          )
        : Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(22),
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.Hm().format(widget.vm.state.time!),
                        style: AppTheme.title2,
                      ),
                      _toggle()
                    ],
                  ),
                ),
              ),
              onTap: () {
                FocusScope.of(context).unfocus();
                _selectTime(context);
              },
            ),
          );
  }

  _toggle() {
    bool isPM = (widget.vm.state.time!.hour > 12 ||
        (widget.vm.state.time!.hour == 12 &&
            widget.vm.state.time!.minute >= 0));

    return Row(
      children: [
        GestureDetector(
          onTap: widget.vm.toggleTime,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: isPM ? Colors.transparent : AppTheme.defaultBlueLight,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
              child: AutoSizeText(
                'AM',
                minFontSize: 8,
                maxFontSize: 11,
                style: TextStyle(
                    color: isPM ? Theme.of(context).textTheme.bodySmall!.color : AppTheme.white),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: widget.vm.toggleTime,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: isPM ? AppTheme.defaultBlueLight : Colors.transparent,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
              child: AutoSizeText(
                'PM',
                minFontSize: 8,
                maxFontSize: 11,
                style: TextStyle(
                    color: isPM ? AppTheme.white : Theme.of(context).textTheme.bodySmall!.color),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    DateTime? selectedTime = widget.vm.state.time;
    final initialTime = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);

    await showCupertinoModalPopup(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(22),
          ),
          margin: EdgeInsets.only(
            right: 20,
            left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                color: AppTheme.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text(tr('Cancel'), style: AppTheme.body1),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      tr('TimeSetting'),
                      style: AppTheme.body1,
                    ),
                    TextButton(
                      child: Text(tr('Okay'), style: AppTheme.body1),
                      onPressed: () {
                        widget.vm.selectTime(selectedTime ?? initialTime);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    brightness: widget.theme.brightness,
                  ),
                  child: CupertinoDatePicker(
                    initialDateTime: selectedTime ?? initialTime,
                    onDateTimeChanged: (DateTime newDateTime) {
                      selectedTime = newDateTime;
                    },
                    mode: CupertinoDatePickerMode.time,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
