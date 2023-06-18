import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
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
    var theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
          var result = await showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(tr('LeaveAlert'),style: Theme.of(context)
                    .textTheme
                    .titleLarge,),
                content: Text(tr('NoSaveContent'),style: Theme.of(context)
                    .textTheme
                    .bodyMedium,),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: Text(
                          tr('Cancel'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(false); // 다이얼로그 닫기
                        },
                      ),
                      TextButton(
                        child: Text(
                          tr('Leave'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(true); // 다이얼로그 닫기
                        },
                      ),
                    ],
                  )
                ],
              ));

          if(result) return true;
          else return false;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              leading: const CloseButton(),
              title: Text(
                tr('AddAlarm'),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.check,
                  ),
                  onPressed: () async {
                    var result = await showDialog<bool>(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text(tr('Save')),
                              content: Text(tr('SaveAlert')),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      child: Text(
                                        tr('Cancel'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(false); // 다이얼로그 닫기
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        tr('Save'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(true); // 다이얼로그 닫기
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ));

                  if (result == true) {
                    await vm.save(titleController.text, contentController.text);
                    await listVm.loadAll();
                    Navigator.pop(context);
                  }
                },
              )
            ]),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(tr('AlarmSetting')),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: theme.brightness == Brightness.dark
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
                          hintText: 'title',
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(22),
                          elevation: 5,
                          child: CustomTextField(
                            controller: titleController,
                            hintText: 'title',
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: theme.brightness == Brightness.dark
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
                          hintText: 'content',
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(22),
                          elevation: 5,
                          child: CustomTextField(
                            controller: contentController,
                            hintText: 'content',
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              _title(tr('DateSetting')),
              SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomRadioButton(
                        title: tr('First'),
                        isOn: vm.dateType == AlarmDate.first,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          vm.selectDate(1);
                        },
                        isCustom: false,
                        theme: theme,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomRadioButton(
                        title: tr('Last'),
                        isOn: vm.dateType == AlarmDate.last,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          vm.selectDate(-1);
                        },
                        isCustom: false,
                        theme: theme,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomRadioButton(
                        title: tr('Custom'),
                        isOn: vm.dateType == AlarmDate.custom,
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          vm.selectDate(DateTime.now().day);

                          var result = await showCupertinoModalPopup<int?>(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) =>
                                  NumberPicker(vm: vm));

                          if (result != null) vm.selectDate(result);
                        },
                        isCustom: true,
                        day: alarm.date,
                        theme: theme,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              _title(tr('TimeSetting')),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TimePicker(
                  vm: vm,
                  theme: theme,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _title(tr('AdvanceAlarm')),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    OptionField(
                      onTap: () => vm.dayBeforeOneDayOn(),
                      isOn: alarm.bfOneDayOn,
                      title: tr('Before1'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OptionField(
                      onTap: () => vm.dayBeforeThreeDayOn(),
                      isOn: alarm.bfThreeDayOn,
                      title: tr('Before3'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OptionField(
                      onTap: () => vm.dayBeforeOneWeekOn(),
                      isOn: alarm.bfOneWeekOn,
                      title: tr('Before7'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _title(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
