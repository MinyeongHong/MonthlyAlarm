import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monthly_alarm_app/app_theme.dart';
import 'package:monthly_alarm_app/ui/widget/custom_radio.dart';
import 'package:monthly_alarm_app/ui/widget/number_picker.dart';
import 'package:monthly_alarm_app/ui/widget/option_field.dart';
import 'package:monthly_alarm_app/ui/widget/text_edit_field.dart';
import 'package:monthly_alarm_app/ui/widget/time_picker.dart';

import '../data/alarm.dart';
import '../provider/alarm_detail_provider.dart';

enum AlarmDate { first, last, custom, none }

final dayTypeProvider = StateProvider<AlarmDate>((ref) => AlarmDate.none);

final titleController = TextEditingController();
final contentController = TextEditingController();

class AddAlarmScreen extends ConsumerWidget {
  const AddAlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Alarm alarm = ref.watch(alarmDetailProvider);
    AlarmDetailViewModel vm = ref.watch(alarmDetailProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.backgroundBlue,
      appBar: AppBar(
          leading: const CloseButton(
            color: AppTheme.accentBlue,
          ),
          title: const Text(
            'Add Alarm',
            style: AppTheme.title1,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.check,
                color: AppTheme.accentBlue,
              ),
              onPressed: () {
                print(alarm);
              },
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: titleController,
              hintText: 'Title',
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: contentController,
              hintText: 'Content',
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '날짜 설정',
                style: AppTheme.title1,
              ),
            ),
            CustomRadioButton(
              title: '매월 1일',
              isOn: ref.watch(dayTypeProvider) == AlarmDate.first,
              onTap: () {
                ref.read(dayTypeProvider.notifier).state = AlarmDate.first;
                vm.selectDate(1);
              },
              isCustom: false,
            ),
            CustomRadioButton(
              title: '매월 말일',
              isOn: ref.watch(dayTypeProvider) == AlarmDate.last,
              onTap: () {
                ref
                    .read(dayTypeProvider.notifier)
                    .update((state) => state = AlarmDate.last);
                vm.selectDate(-1);
              },
              isCustom: false,
            ),
            CustomRadioButton(
              title: '직접 지정',
              isOn: ref.watch(dayTypeProvider) == AlarmDate.custom,
              onTap: () async {
                vm.selectDate(DateTime.now().day);
                ref
                    .read(dayTypeProvider.notifier)
                    .update((state) => state = AlarmDate.custom);

                await showCupertinoModalPopup<void>(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) => NumberPicker(vm: vm));
              },
              isCustom: true,
              day: alarm.date,
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '시간 설정',
                style: AppTheme.title1,
              ),
            ),
            TimePicker(vm:vm),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '미리 알림',
                style: AppTheme.title1,
              ),
            ),
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
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}