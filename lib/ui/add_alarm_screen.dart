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

class AddAlarmScreen extends ConsumerStatefulWidget {
  AddAlarmScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddAlarmScreen> createState() => _AddAlarmScreenState();
}

class _AddAlarmScreenState extends ConsumerState<AddAlarmScreen> {
  late final TextEditingController titleController;
  late final TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Alarm alarm = ref.watch(alarmDetailViewModelProvider());
    AlarmDetailViewModel vm = ref.read(alarmDetailViewModelProvider().notifier);
    AlarmListViewModel listVm = ref.read(alarmListViewModelProvider.notifier);
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            leading: const CloseButton(),
            title: const Text(
              'Add Alarm',
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.check,
                ),
                onPressed: () async {
                  await vm.saveText(
                      titleController.text, contentController.text);
                  await vm.save();
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
                isDark
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(42),
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
                        borderRadius: BorderRadius.circular(42),
                        elevation: 5,
                        child: CustomTextField(
                          controller: titleController,
                          hintText: 'Title',
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    child: isDark
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(42),
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
                            borderRadius: BorderRadius.circular(42),
                            elevation: 5,
                            child: CustomTextField(
                              controller: contentController,
                              hintText: 'Content',
                            ),
                          )),
                _title('?????? ??????'),
                SizedBox(
                  child: Column(
                    children: [
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
                              builder: (BuildContext context) =>
                                  NumberPicker(vm: vm));

                          if (result != null) vm.selectDate(result);
                        },
                        isCustom: true,
                        day: alarm.date,
                      ),
                    ],
                  ),
                ),
                _title('?????? ??????'),
                SizedBox(
                  child: TimePicker(vm: vm),
                ),
                _title('?????? ??????'),
                SizedBox(
                  child: Column(
                    children: [
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
