import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monthly_alarm_app/provider/alarm_detail_provider.dart';

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
      shadowColor: AppTheme.backgroundBlue,
      borderRadius: BorderRadius.circular(22),
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.vm.state.time.hour.toString() + ' : '+
                    widget.vm.state.time.minute.toString(),style: AppTheme.title1,),
                _toggle()
              ],
            ),
          ),
        ),
        onTap: () {
          _selectTime(context);
        },
      ),
    );
  }

  _toggle() {
    bool _isPM = (widget.vm.state.time.hour > 12 ||
        (widget.vm.state.time.hour == 12 && widget.vm.state.time.minute >= 0));

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: _isPM ?Colors.transparent :AppTheme.defaultBlue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('AM'),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: _isPM? AppTheme.defaultBlue : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('PM'),
          ),
        )
      ],
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();

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
                      child: Text('취소', style: AppTheme.body1),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      '시간 설정',
                      style: AppTheme.body1,
                    ),
                    TextButton(
                      child: Text('확인', style: AppTheme.body1),
                      onPressed: () {
                        widget.vm.selectTime(selectedTime);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime newDateTime) {
                    selectedTime = TimeOfDay.fromDateTime(newDateTime);
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
