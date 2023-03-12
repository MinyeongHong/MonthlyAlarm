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
    var theme = Theme.of(context);
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
                _title('알람 설정'),
                theme.brightness == Brightness.dark
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
                  child: CustomTextField(
                    controller: titleController,
                    hintText: 'Title',
                  ),
                )
                    : Material(
                  borderRadius: BorderRadius.circular(22),
                  elevation: 5,
                  child: CustomTextField(
                    controller: titleController,
                    hintText: 'Title',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                theme.brightness == Brightness.dark
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
                  child: CustomTextField(
                    controller: contentController,
                    hintText: 'Content',
                  ),
                )
                    : Material(
                  borderRadius: BorderRadius.circular(22),
                  elevation: 5,
                  child: CustomTextField(
                    controller: contentController,
                    hintText: 'Content',
                  ),
                ),
                _title('날짜 설정'),
                SizedBox(
                  child: Column(
                    children: [
                      CustomRadioButton(
                        title: '매월 1일',
                        isOn: vm.dateType == AlarmDate.first,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          vm.selectDate(1);
                        },
                        isCustom: false,
                        theme: theme,
                      ),
                      CustomRadioButton(
                        title: '매월 말일',
                        isOn: vm.dateType == AlarmDate.last,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          vm.selectDate(-1);
                        },
                        isCustom: false,
                        theme: theme,
                      ),
                      CustomRadioButton(
                        title: '직접 지정',
                        isOn: vm.dateType == AlarmDate.custom,
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          vm.selectDate(DateTime.now().day);

                          var result = await showCupertinoModalPopup<int?>(
                              barrierDismissible: true,
                              context: context,
                              builder: (BuildContext context) =>
                                  NumberPicker(vm: vm));

                          if (result != null) vm.selectDate(result);
                        },
                        isCustom: true,
                        day: alarm.date,
                        theme: theme,
                      ),
                    ],
                  ),
                ),
                _title('시간 설정'),
                SizedBox(
                  child: TimePicker(vm: vm,theme: theme,),
                ),
                _title('미리 알림'),
                SizedBox(
                  child: Column(
                    children: [
                      OptionField(
                        onTap: () => vm.dayBeforeOneDayOn(),
                        isOn: alarm.bfOneDayOn,
                        title: '하루 전 알림',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OptionField(
                        onTap: () => vm.dayBeforeThreeDayOn(),
                        isOn: alarm.bfThreeDayOn,
                        title: '3일 전 알림',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OptionField(
                        onTap: () => vm.dayBeforeOneWeekOn(),
                        isOn: alarm.bfOneWeekOn,
                        title: '7일 전 알림',
                      ),
                    ],
                  ),
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
        maxFontSize: 18,
      ),
    );
  }
}
