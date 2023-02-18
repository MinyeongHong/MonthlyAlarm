import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../provider/alarm_detail_provider.dart';

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
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.only(
              right: 20,
              left: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              children: [
                Material(child: Text('매월 ${selectedDay}일')),
                Expanded(
                  child: CupertinoPicker(
                    scrollController: controller,
                    itemExtent: 50,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedDay = index + 1;
                      });
                      widget.vm.selectDate(selectedDay);
                    },
                    children: List<Widget>.generate(
                        31,
                        (int index) => Center(
                              child: Text('${index + 1}일'),
                            )),
                  ),
                ),
                if (selectedDay > 28)
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppTheme.transParentBlue),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${selectedDay}일이 없는 달에는 알람이 울리지 않습니다.',
                              style: TextStyle(
                                  color: AppTheme.accentBlue,
                                  fontStyle: FontStyle.italic),
                            ),
                          )),
                    ),
                  ),
              ],
            ),
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.pop(context, 'ok');
          //     },
          //     child: Text('확인')),
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.pop(context, 'cancel');
          //     },
          //     child: Text('취소')),
        ],
      ),
    );
  }
}