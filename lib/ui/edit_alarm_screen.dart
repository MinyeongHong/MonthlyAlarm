import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monthly_alarm_app/app_theme.dart';
import 'package:monthly_alarm_app/provider/alarm_list_viewmodel.dart';
import 'package:monthly_alarm_app/ui/widget/custom_radio.dart';
import 'package:monthly_alarm_app/ui/widget/number_picker.dart';
import 'package:monthly_alarm_app/ui/widget/option_field.dart';
import 'package:monthly_alarm_app/ui/widget/text_edit_field.dart';
import 'package:monthly_alarm_app/ui/widget/time_picker.dart';

import '../data/alarm.dart';
import '../provider/alarm_detail_viewmodel.dart';

class EditAlarmScreen extends ConsumerStatefulWidget {
  final Alarm alarm;

  const EditAlarmScreen({required this.alarm, Key? key}) : super(key: key);

  @override
  ConsumerState<EditAlarmScreen> createState() => _EditAlarmScreenState();
}

class _EditAlarmScreenState extends ConsumerState<EditAlarmScreen> {

  late final TextEditingController titleController;
  late final TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.alarm.title);
    contentController = TextEditingController(text: widget.alarm.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Alarm alarm = ref.watch(alarmDetailViewModelProvider(widget.alarm));
    AlarmDetailViewModel vm = ref.read(alarmDetailViewModelProvider(widget.alarm).notifier);
    AlarmListViewModel listVm = ref.read(alarmListViewModelProvider.notifier);

    return GestureDetector(
      onTap:()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            leading: const CloseButton(),
            title: Text(
              'Edit Alarm',
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.check,
                ),
                onPressed: () async {
                    await vm.saveText(
                        titleController.text, contentController.text);
                    await vm.update();
                    await listVm.loadAll();
                    Navigator.pop(context);
                },
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title('?????? ??????'),
                CustomTextField(
                  controller: titleController,
                  hintText: 'Title',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: contentController,
                  hintText: 'Content',
                ),
                _title('?????? ??????'),
                CustomRadioButton(
                  title: '?????? 1???',
                  isOn: vm.dateType == AlarmDate.first,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    vm.selectDate(1);
                  },
                  isCustom: false,
                ),
                CustomRadioButton(
                  title: '?????? ??????',
                  isOn: vm.dateType == AlarmDate.last,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    vm.selectDate(-1);
                  },
                  isCustom: false,
                ),
                CustomRadioButton(
                  title: '?????? ??????',
                  isOn: vm.dateType == AlarmDate.custom,
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    vm.selectDate(DateTime.now().day);

                    var result = await showCupertinoModalPopup<int?>(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) => NumberPicker(vm: vm));

                    if(result != null) vm.selectDate(result);
                  },
                  isCustom: true,
                  day: alarm.date,
                ),
                _title('?????? ??????'),
                TimePicker(vm: vm),
                _title('?????? ??????'),
                OptionField(
                  onTap: () => vm.dayBeforeOneDayOn(),
                  isOn: alarm.bfOneDayOn,
                  title: '?????? ??? ??????',
                ),
                const SizedBox(
                  height: 10,
                ),
                OptionField(
                  onTap: () => vm.dayBeforeThreeDayOn(),
                  isOn: alarm.bfThreeDayOn,
                  title: '3??? ??? ??????',
                ),
                const SizedBox(
                  height: 10,
                ),
                OptionField(
                  onTap: () => vm.dayBeforeOneWeekOn(),
                  isOn: alarm.bfOneWeekOn,
                  title: '7??? ??? ??????',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _title(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: AutoSizeText(
        title,
        // style: AppTheme.title1,
        maxFontSize: 18,
      ),
    );
  }
}
