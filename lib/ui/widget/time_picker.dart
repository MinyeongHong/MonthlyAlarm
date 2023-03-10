import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monthly_alarm_app/provider/alarm_detail_viewmodel.dart';
import 'package:intl/intl.dart';
import '../../app_theme.dart';

class TimePicker extends StatefulWidget {
  final AlarmDetailViewModel vm;

  const TimePicker({Key? key, required this.vm}) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
     // shadowColor: AppTheme.backgroundBlueLight,
      borderRadius: BorderRadius.circular(22),
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat.Hm().format(widget.vm.state.time!),style: AppTheme.title2,),
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
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 6),
              child: AutoSizeText('AM',minFontSize:8,maxFontSize: 11,style: TextStyle(color: isPM ? AppTheme.defaultTextLight:AppTheme.white),),
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
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 6),
              child: AutoSizeText('PM',minFontSize:8,maxFontSize: 11,style: TextStyle(color: isPM ? AppTheme.white:AppTheme.defaultTextLight),),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    DateTime? selectedTime = widget.vm.state.time;
    final initialTime = DateTime(DateTime
        .now()
        .year, DateTime
        .now()
        .month, DateTime
        .now()
        .day, 0, 0, 0);

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          height: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text('??????', style: AppTheme.body1),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      '?????? ??????',
                      style: AppTheme.body1,
                    ),
                    TextButton(
                      child: Text('??????', style: AppTheme.body1),
                      onPressed: () {
                        widget.vm.selectTime(selectedTime ?? initialTime);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: selectedTime ?? initialTime,
                  onDateTimeChanged: (DateTime newDateTime) {
                    selectedTime = newDateTime;
                  },
                  mode: CupertinoDatePickerMode.time,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
