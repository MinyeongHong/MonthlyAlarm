import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../provider/alarm_detail_viewmodel.dart';

class NumberPicker extends StatefulWidget {
  final AlarmDetailViewModel vm;

  const NumberPicker({Key? key, required this.vm}) : super(key: key);

  @override
  State<NumberPicker> createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  var selectedDay = DateTime.now().day;
  final FixedExtentScrollController controller = FixedExtentScrollController(
      initialItem: DateTime.now().day - 1); //TODO check

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text(tr('Cancel'))),
                  Material(
                    color: AppTheme.transparent,
                    child: Text(
                      tr('DateSetting'),
                      style: AppTheme.body1,
                    ),
                  ),
                  TextButton(onPressed: (){
                    Navigator.pop(context,selectedDay);
                  }, child: Text(tr('Okay'))),
                ]),
                Expanded(
                  child: CupertinoPicker(
                    scrollController: controller,
                    itemExtent: 50,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedDay = index + 1;
                      });
                    },
                    children: List<Widget>.generate(
                        31,
                        (int index) =>
                            Center(
                              child: Text(
                                'Date'.plural(index + 1),
                                style: Theme.of(context).textTheme.bodyLarge,
                            ))
                  ),
                ),),
                if (selectedDay > 28)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Material(
                      color: AppTheme.transparent,
                      child: Text(
                        "NoAlarmAlert".tr(args:[selectedDay.toString()]),
                        textAlign: TextAlign.center,
                        style: AppTheme.sub1.apply(color:Theme.of(context).textTheme.bodySmall!.color),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
