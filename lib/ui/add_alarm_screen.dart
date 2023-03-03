// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:monthly_alarm_app/app_theme.dart';
// import 'package:monthly_alarm_app/provider/alarm_list_provider.dart';
// import 'package:monthly_alarm_app/ui/widget/custom_radio.dart';
// import 'package:monthly_alarm_app/ui/widget/number_picker.dart';
// import 'package:monthly_alarm_app/ui/widget/option_field.dart';
// import 'package:monthly_alarm_app/ui/widget/text_edit_field.dart';
// import 'package:monthly_alarm_app/ui/widget/time_picker.dart';
//
// import '../data/alarm.dart';
// import '../provider/alarm_detail_provider.dart';
//
// class AddAlarmScreen extends ConsumerStatefulWidget {
//   AddAlarmScreen({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<AddAlarmScreen> createState() => _AddAlarmScreenState();
// }
//
// class _AddAlarmScreenState extends ConsumerState<AddAlarmScreen> {
//   late final TextEditingController titleController;
//   late final TextEditingController contentController;
//   late final dynamic alarmDetailProvider;
//
//   @override
//   void initState() {
//     super.initState();
//     titleController = TextEditingController();
//     contentController = TextEditingController();
//     alarmDetailProvider =
//         StateNotifierProvider.autoDispose<AlarmDetailViewModel, Alarm>(
//             (ref) => AlarmDetailViewModel());
//   }
//
//   @override
//   void dispose() {
//     titleController.dispose();
//     contentController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Alarm alarm = ref.watch(alarmDetailProvider);
//     AlarmDetailViewModel vm = ref.read(alarmDetailProvider.notifier);
//     AlarmListViewModel listVm = ref.read(alarmListProvider.notifier);
//
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: AppTheme.backgroundBlue,
//         appBar: AppBar(
//             leading: const CloseButton(
//               color: AppTheme.accentBlue,
//             ),
//             title: const Text(
//               'Add Alarm',
//               style: AppTheme.title1,
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.transparent,
//             elevation: 0.0,
//             actions: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.check,
//                   color: AppTheme.accentBlue,
//                 ),
//                 onPressed: () async {
//                   await vm.saveText(
//                       titleController.text, contentController.text);
//                   await vm.save();
//                   await listVm.loadAll();
//                   Navigator.pop(context);
//                 },
//               )
//             ]),
//         body: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _title('알람 설정'),
//                 SizedBox(
//                   child: CustomTextField(
//                     controller: titleController,
//                     hintText: 'Title',
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   child: CustomTextField(
//                     controller: contentController,
//                     hintText: 'Content',
//                   ),
//                 ),
//                 _title('날짜 설정'),
//                 SizedBox(
//                   child: Column(
//                     children: [
//                       CustomRadioButton(
//                         title: '매월 1일',
//                         isOn: ref.watch(dayTypeProvider) == AlarmDate.first,
//                         onTap: () {
//                           FocusScope.of(context).unfocus();
//                           ref.read(dayTypeProvider.notifier).state =
//                               AlarmDate.first;
//                           vm.selectDate(1);
//                         },
//                         isCustom: false,
//                       ),
//                       CustomRadioButton(
//                         title: '매월 말일',
//                         isOn: ref.watch(dayTypeProvider) == AlarmDate.last,
//                         onTap: () {
//                           FocusScope.of(context).unfocus();
//                           ref
//                               .read(dayTypeProvider.notifier)
//                               .update((state) => state = AlarmDate.last);
//                           vm.selectDate(-1);
//                         },
//                         isCustom: false,
//                       ),
//                       CustomRadioButton(
//                         title: '직접 지정',
//                         isOn: ref.watch(dayTypeProvider) == AlarmDate.custom,
//                         onTap: () async {
//                           FocusScope.of(context).unfocus();
//                           vm.selectDate(DateTime.now().day);
//
//                           var result = await showCupertinoModalPopup<int?>(
//                               barrierDismissible: true,
//                               context: context,
//                               builder: (BuildContext context) =>
//                                   NumberPicker(vm: vm));
//
//                           if (result != null) {
//                             vm.selectDate(result);
//                             if (result == 1) {
//                               ref
//                                   .read(dayTypeProvider.notifier)
//                                   .update((state) => state = AlarmDate.first);
//                             } else {
//                               ref
//                                   .read(dayTypeProvider.notifier)
//                                   .update((state) => state = AlarmDate.custom);
//                             }
//                           }
//                         },
//                         isCustom: true,
//                         day: alarm.date,
//                       ),
//                     ],
//                   ),
//                 ),
//                 _title('시간 설정'),
//                 SizedBox(
//                   child: TimePicker(vm: vm),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   child: AutoSizeText(
//                     '미리 알림',
//                     maxFontSize: 18,
//                   ),
//                 ),
//                 SizedBox(
//                   child: Column(
//                     children: [
//                       OptionField(
//                         onTap: () => vm.dayBeforeOneDayOn(),
//                         isOn: alarm.bfOneDayOn,
//                         title: '하루 전 알림',
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       OptionField(
//                         onTap: () => vm.dayBeforeThreeDayOn(),
//                         isOn: alarm.bfThreeDayOn,
//                         title: '3일 전 알림',
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       OptionField(
//                         onTap: () => vm.dayBeforeOneWeekOn(),
//                         isOn: alarm.bfOneWeekOn,
//                         title: '7일 전 알림',
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Padding _title(String title) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 16),
//       child: AutoSizeText(
//         title,
//         // style: AppTheme.title1,
//         maxFontSize: 18,
//       ),
//     );
//   }
// }
