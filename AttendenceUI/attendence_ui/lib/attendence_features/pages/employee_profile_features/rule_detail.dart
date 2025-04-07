// import 'dart:io';
//
// import 'package:attendence_ui/attendence_features/pages/employee_profile_features/primarybutton.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'event.dart';
//
//
// class RuleDetail extends StatefulWidget {
//   final String rule;
//   final int empId;
//   final int ruleId;
//
//   const RuleDetail({super.key, required this.rule, required this.empId, required this.ruleId});
//
//   @override
//   State<RuleDetail> createState() => _RuleDetailState();
// }
//
// class _RuleDetailState extends State<RuleDetail> {
//   Map<String, dynamic>? employeeData;
//   File? selectedImageFile;
//
//   DateTime? selectDate;
//
//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//
//     if (image != null) {
//       setState(() {
//         selectedImageFile = File(image.path);
//       });
//     }
//   }
//
//   // String? selectedDate;
//   bool cutSalary = false; // Define the state variable
//
//   List<String> dates = [];
//
//   bool showCalendar = false;
//   bool showCalendar2 = false;
//   bool isCostPerMissedSelected = false;
//   bool isSickLeaveSelected = false;
//   bool isCOthersSelected = false;
//   bool isDeductedDaySalarySelected = false;
//
//   int selectedOption = -1;
//   int selectedRadioIndex = -1;
//   int selectedRadioIndex2 = -1;
//
//   final List<bool> daysChecked = List<bool>.filled(7, false);
//   final List<bool> showCalendarList = List<bool>.filled(4, false);
//
//   List<String> generateDatesForCurrentMonth() {
//     List<String> dateList = [];
//     DateTime now = DateTime.now();
//     int daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);
//     DateFormat formatter = DateFormat('yyyy-MM-dd');
//
//     for (int i = 1; i <= daysInMonth; i++) {
//       dateList.add(formatter.format(DateTime(now.year, now.month, i)));
//     }
//
//     return dateList;
//   }
//
//   //final dbHelper = DatabaseHelper2.instance;
//   String staticText = '';
//   bool _overtime = false;
//
//   // void insertStaticText() async {
//   //   await dbHelper.insertStaticText();
//   //   final allRows = await dbHelper.queryAllRows();
//   //   setState(() {
//   //     staticText = allRows.isNotEmpty ? allRows[4]['english'] : 'No data found';
//   //   });
//   // }
//
//   TimeOfDay selectedAMStartTime = const TimeOfDay(hour: 8, minute: 0);
//   TimeOfDay selectedAMEndTime = const TimeOfDay(hour: 12, minute: 0);
//   TimeOfDay selectedPMStartTime = const TimeOfDay(hour: 13, minute: 0);
//   TimeOfDay selectedPMEndTime = const TimeOfDay(hour: 17, minute: 0);
//   TimeOfDay selectedOverStartTime = const TimeOfDay(hour: 18, minute: 0);
//   TimeOfDay selectedOverEndTime = const TimeOfDay(hour: 20, minute: 0);
//
//   final TextEditingController workingDaysController = TextEditingController();
//   final TextEditingController workingDaysWeekController = TextEditingController();
//
//   final TextEditingController leaveDaysController = TextEditingController();
//
//   final TextEditingController latePenaltyPerOccurrenceController = TextEditingController();
//
//   final TextEditingController latenessMinuteController = TextEditingController();
//
//   final TextEditingController earlyPenaltyPerOccurrenceController = TextEditingController();
//
//   final TextEditingController unitRateController = TextEditingController();
//   final TextEditingController incrementalController = TextEditingController();
//
//   final TextEditingController unitsProducedController = TextEditingController();
//
//   final TextEditingController hourlyRateController = TextEditingController();
//
//   final TextEditingController fixedPenaltyController = TextEditingController();
//   final TextEditingController graceHourController = TextEditingController();
//
//   final TextEditingController dayShiftController = TextEditingController();
//   final TextEditingController nightShiftController = TextEditingController();
//
//   final TextEditingController lastLateTimeController = TextEditingController();
//   final TextEditingController costPerMissedPunch = TextEditingController();
//   final TextEditingController missAcceptableTime = TextEditingController();
//
//   final TextEditingController goAfterMinutes = TextEditingController();
//
//   final TextEditingController costPerMissedPunchAmount = TextEditingController();
//   final TextEditingController deductedForOneDay = TextEditingController();
//   final TextEditingController minutesLater = TextEditingController();
//   final TextEditingController costOvertime = TextEditingController();
//   final TextEditingController overtimeWillNotBeCountedUntil = TextEditingController();
//
//   final TextEditingController laterTime = TextEditingController();
//
//   final TextEditingController weekendOvertimeController = TextEditingController();
//   final TextEditingController holidayOvertimeController = TextEditingController();
//   final TextEditingController lateTime = TextEditingController();
//   final TextEditingController hourlyLateTime = TextEditingController();
//   final TextEditingController enterLeaveDay = TextEditingController();
//   final TextEditingController enterLeaveDayCost = TextEditingController();
//   final TextEditingController enterLeaveDayOther = TextEditingController();
//   final TextEditingController enterLeaveDayCostOther = TextEditingController();
//   final TextEditingController _overtimeRateController = TextEditingController();
//
//   List<DateTime> _selectedHolidays = [];
//   List<DateTime> _selectGeneralDays = [];
//   List<DateTime> _selectReplaceDays = [];
//   List<Map<String, dynamic>> _selectMissPunchDocuments = [];
//
//   List<DateTime> _maternalLeave = [];
//   List<DateTime> _paternalLeave = [];
//   List<DateTime> _marriageLeave = [];
//   List<DateTime> _companyHolidayLeave = [];
//   List<DateTime> _sickLeave = [];
//   List<DateTime> _otherLeave = [];
//
//   // final DatabaseHelper databaseHelper = DatabaseHelper();
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeData().then((value) => setState(() {}));
//   }
//
//   Future<void> _initializeData() async {
//     await _loadRuleDetails();
//     //insertStaticText();
//     dates = generateDatesForCurrentMonth();
//
//     if (widget.ruleId == 1) {
//       await _loadSelectedHolidays();
//     }
//
//     if (widget.ruleId == 3) {
//       await _loadGeneralDays();
//     }
//
//     if (widget.ruleId == 12) {
//       await _loadReplaceDays();
//     }
//
//     if (widget.ruleId == 10) {
//       await _loadMaternalDays();
//       await _loadPaternalDays();
//       await _loadMarriageDays();
//       await _loadCompanyHolyDays();
//       await _loadSickDays();
//       await _loadOtherDays();
//
//       // Update the showCalendarList based on the non-empty state of the leave lists
//       showCalendarList[0] = _maternalLeave.isNotEmpty;
//       showCalendarList[1] = _paternalLeave.isNotEmpty;
//       showCalendarList[2] = _marriageLeave.isNotEmpty;
//       showCalendarList[3] = _companyHolidayLeave.isNotEmpty;
//
//       if (_sickLeave.isNotEmpty) {
//         isSickLeaveSelected = true;
//         showCalendar = true;
//       }
//
//       if (_otherLeave.isNotEmpty) {
//         isCOthersSelected = true;
//         showCalendar2 = true;
//       }
//     }
//
//     if (widget.ruleId == 11) {
//       await _loadDocuments();
//     }
//   }
//
//   ///documents
//
//   // Future<void> _loadDocuments() async {
//   //   _selectMissPunchDocuments = await databaseHelper.getPunchDocumentsByEmpId(widget.empId);
//   // }
//
//   ///maternal
//
//   // Future<void> _loadMaternalDays() async {
//   //   final holidays = await databaseHelper.getMaternalLeaveDay(widget.empId);
//   //   setState(() {
//   //     _maternalLeave = holidays.map((e) => DateTime.parse(e['date'])).toList();
//   //   });
//   // }
//
//   // Future<void> _saveMaternalHolyDayToDatabase() async {
//   //   await databaseHelper.deleteMaternalLeaveDay(widget.empId);
//   //
//   //   for (DateTime date in _maternalLeave) {
//   //     await databaseHelper.insertMaternalLeaveDay(widget.empId, date.toIso8601String());
//   //   }
//   // }
//
//   // void _onMaternalHolyDayPressed(DateTime date, List<Event> events) {
//   //   setState(() {
//   //     if (_maternalLeave.contains(date)) {
//   //       _maternalLeave.remove(date);
//   //     } else {
//   //       _maternalLeave.add(date);
//   //     }
//   //   });
//   //   _saveMaternalHolyDayToDatabase();
//   // }
//
//   ///paternal
//
//   Future<void> _loadPaternalDays() async {
//     final holidays = await databaseHelper.getPaternalLeaveDay(widget.empId);
//     setState(() {
//       _paternalLeave = holidays.map((e) => DateTime.parse(e['date'])).toList();
//     });
//   }
//
//   Future<void> _savePaternalHolyDayToDatabase() async {
//     await databaseHelper.deletePaternalLeaveDay(widget.empId);
//
//     for (DateTime date in _paternalLeave) {
//       await databaseHelper.insertPaternalLeaveDay(widget.empId, date.toIso8601String());
//     }
//   }
//
//   void _onPaternalHolyDayPressed(DateTime date, List<Event> events) {
//     setState(() {
//       if (_paternalLeave.contains(date)) {
//         _paternalLeave.remove(date);
//       } else {
//         _paternalLeave.add(date);
//       }
//     });
//     _savePaternalHolyDayToDatabase();
//   }
//
//   ///marriage
//
//   Future<void> _loadMarriageDays() async {
//     final holidays = await databaseHelper.getMarriageLeaveDay(widget.empId);
//     setState(() {
//       _marriageLeave = holidays.map((e) => DateTime.parse(e['date'])).toList();
//     });
//   }
//
//   Future<void> _saveMarriageHolyDayToDatabase() async {
//     await databaseHelper.deleteMarriageLeaveDay(widget.empId);
//
//     for (DateTime date in _marriageLeave) {
//       await databaseHelper.insertMarriageLeaveDay(widget.empId, date.toIso8601String());
//     }
//   }
//
//   void _onMarriageHolyDayPressed(DateTime date, List<Event> events) {
//     setState(() {
//       if (_marriageLeave.contains(date)) {
//         _marriageLeave.remove(date);
//       } else {
//         _marriageLeave.add(date);
//       }
//     });
//     _saveMarriageHolyDayToDatabase();
//   }
//
//   ///company Holiday
//
//   Future<void> _loadCompanyHolyDays() async {
//     final holidays = await databaseHelper.getCompanyHolidayLeaveDay(widget.empId);
//     setState(() {
//       _companyHolidayLeave = holidays.map((e) => DateTime.parse(e['date'])).toList();
//     });
//   }
//
//   Future<void> _saveCompanyHolyDayToDatabase() async {
//     await databaseHelper.deleteCompanyHolidayLeaveDay(widget.empId);
//
//     for (DateTime date in _companyHolidayLeave) {
//       await databaseHelper.insertCompanyHolidayLeaveDay(widget.empId, date.toIso8601String());
//     }
//   }
//
//   void _onCompanyHolyDayPressed(DateTime date, List<Event> events) {
//     setState(() {
//       if (_companyHolidayLeave.contains(date)) {
//         _companyHolidayLeave.remove(date);
//       } else {
//         _companyHolidayLeave.add(date);
//       }
//     });
//     _saveCompanyHolyDayToDatabase();
//   }
//
//   ///sickDay
//
//   Future<void> _loadSickDays() async {
//     final holidays = await databaseHelper.getSickLeaveDay(widget.empId);
//     setState(() {
//       _sickLeave = holidays.map((e) => DateTime.parse(e['date'])).toList();
//     });
//   }
//
//   Future<void> _saveSickDaysToDatabase() async {
//     await databaseHelper.deleteSickLeaveDay(widget.empId);
//
//     for (DateTime date in _sickLeave) {
//       await databaseHelper.createOrUpdateSickLeaveDay(widget.empId, date.toIso8601String(), '0', '0');
//     }
//   }
//
//   void _onSickDayPressed(DateTime date, List<Event> events) {
//     setState(() {
//       if (_sickLeave.contains(date)) {
//         _sickLeave.remove(date);
//       } else {
//         _sickLeave.add(date);
//       }
//     });
//     _saveSickDaysToDatabase();
//   }
//
//   ///otherDay
//
//   Future<void> _loadOtherDays() async {
//     final holidays = await databaseHelper.getOtherLeaveDay(widget.empId);
//     setState(() {
//       _otherLeave = holidays.map((e) => DateTime.parse(e['date'])).toList();
//     });
//   }
//
//   Future<void> _saveOtherDaysToDatabase() async {
//     await databaseHelper.deleteOtherLeaveDay(widget.empId);
//
//     for (DateTime date in _otherLeave) {
//       await databaseHelper.createOrUpdateOtherLeaveDay(widget.empId, date.toIso8601String(), '0', '0');
//     }
//   }
//
//   void _onOtherDayPressed(DateTime date, List<Event> events) {
//     setState(() {
//       if (_otherLeave.contains(date)) {
//         _otherLeave.remove(date);
//       } else {
//         _otherLeave.add(date);
//       }
//     });
//     _saveOtherDaysToDatabase();
//   }
//
//   ///holyDay
//
//   Future<void> _loadSelectedHolidays() async {
//     final holidays = await databaseHelper.getHolidays(widget.empId);
//     setState(() {
//       _selectedHolidays = holidays.map((e) => DateTime.parse(e['date'])).toList();
//     });
//   }
//
//   Future<void> _saveHolidaysToDatabase() async {
//     await databaseHelper.deleteHolidays(widget.empId);
//
//     for (DateTime date in _selectedHolidays) {
//       await databaseHelper.insertHoliday(widget.empId, date.toIso8601String());
//     }
//   }
//
//   void _onHolyDayPressed(DateTime date, List<Event> events) {
//     setState(() {
//       if (_selectedHolidays.contains(date)) {
//         _selectedHolidays.remove(date);
//       } else {
//         _selectedHolidays.add(date);
//       }
//     });
//     _saveHolidaysToDatabase();
//   }
//
//   ///replaceDay
//
//   Future<void> _loadReplaceDays() async {
//     final holidays = await databaseHelper.getReplaceDay(widget.empId);
//     setState(() {
//       _selectReplaceDays = holidays.map((e) => DateTime.parse(e['date'])).toList();
//     });
//   }
//
//   ///generalDay
//
//   Future<void> _loadGeneralDays() async {
//     final holidays = await databaseHelper.getGeneralDay(widget.empId);
//     setState(() {
//       _selectGeneralDays = holidays.map((e) => DateTime.parse(e['date'])).toList();
//     });
//   }
//
//   Future<void> _saveGeneralDaysToDatabase() async {
//     await databaseHelper.deleteGeneralDay(widget.empId);
//
//     for (DateTime date in _selectGeneralDays) {
//       await databaseHelper.insertGeneralDay(widget.empId, date.toIso8601String());
//     }
//   }
//
//   void _onGeneralDayPressed(DateTime date, List<Event> events) {
//     setState(() {
//       if (_selectGeneralDays.contains(date)) {
//         _selectGeneralDays.remove(date);
//       } else {
//         _selectGeneralDays.add(date);
//       }
//     });
//     _saveGeneralDaysToDatabase();
//   }
//
//   void _handleDayPressed(DateTime date, List<Event> events, int rule) {
//     switch (rule) {
//       case 0:
//         _onMaternalHolyDayPressed(date, events);
//         break;
//       case 1:
//         _onMarriageHolyDayPressed(date, events);
//         break;
//       case 2:
//         _onPaternalHolyDayPressed(date, events);
//         break;
//       case 3:
//         _onCompanyHolyDayPressed(date, events);
//         break;
//       default:
//         break;
//     }
//   }
//
//   EventList<Event> _buildMarkedDatesMap(String rule) {
//     List<DateTime> selectedDates;
//
//     // Create a mapping of rules to leave lists
//     final Map<String, List<DateTime>> leaveMapping = {
//       AppLocalizations.of(context)!.maternityLeave: _maternalLeave,
//       AppLocalizations.of(context)!.forMarriage: _marriageLeave,
//       AppLocalizations.of(context)!.paternityLeave: _paternalLeave,
//       AppLocalizations.of(context)!.holidayByCompany: _companyHolidayLeave,
//     };
//
//     // Use the mapping to get the correct dates
//     selectedDates = leaveMapping[rule] ?? [];
//
//     return EventList<Event>(
//       events: {
//         for (var date in selectedDates)
//           date: [
//             Event(
//               date: date,
//               title: 'Selected Leave Day',
//               dot: const Icon(Icons.circle, size: 5.0, color: Colors.blue),
//             ),
//           ]
//       },
//     );
//   }
//
//   // Future<void> _loadRuleDetails() async {
//   //   final ruleDetails = await databaseHelper.getRuleDetail(widget.empId, widget.ruleId);
//   //
//   //   if (ruleDetails != null) {
//   //     setState(() {
//   //       switch (widget.ruleId) {
//   //         case 0:
//   //           selectedAMStartTime = parseTimeString(ruleDetails['param1'] ?? "08:00");
//   //           selectedAMEndTime = parseTimeString(ruleDetails['param2'] ?? "12:00");
//   //           selectedPMStartTime = parseTimeString(ruleDetails['param3'] ?? "13:00");
//   //           selectedPMEndTime = parseTimeString(ruleDetails['param4'] ?? "17:00");
//   //           selectedOverStartTime = parseTimeString(ruleDetails['param5'] ?? "18:00");
//   //           selectedOverEndTime = parseTimeString(ruleDetails['param6'] ?? "20:00");
//   //
//   //           break;
//   //
//   //         case 2: // Assuming ruleId 10 is for "Select Weekend"
//   //           String savedDays = ruleDetails['param1'] ?? '';
//   //           List<String> savedDaysList = savedDays.split(',');
//   //           for (int i = 0; i < weekdays.length; i++) {
//   //             daysChecked[i] = savedDaysList.contains(weekdays[i]);
//   //           }
//   //           break;
//   //
//   //         case 4:
//   //           lastLateTimeController.text = ruleDetails['param1'] ?? '';
//   //           break;
//   //
//   //         case 5:
//   //           minutesLater.text = ruleDetails['param1'] ?? '';
//   //           goAfterMinutes.text = ruleDetails['param2'] ?? '';
//   //
//   //           break;
//   //
//   //         case 6:
//   //           lateTime.text = ruleDetails['param1'] ?? '';
//   //           costOvertime.text = ruleDetails['param2'] ?? '';
//   //
//   //           break;
//   //
//   //         case 7:
//   //           overtimeWillNotBeCountedUntil.text = ruleDetails['param1'] ?? '';
//   //
//   //           break;
//   //
//   //         case 8:
//   //           weekendOvertimeController.text = ruleDetails['param1'] ?? '';
//   //           break;
//   //
//   //         case 9:
//   //           holidayOvertimeController.text = ruleDetails['param1'] ?? '';
//   //           break;
//   //
//   //         case 10:
//   //           enterLeaveDay.text = ruleDetails['param1'] ?? '';
//   //           enterLeaveDayCost.text = ruleDetails['param2'] ?? '';
//   //           enterLeaveDayOther.text = ruleDetails['param3'] ?? '';
//   //           enterLeaveDayCostOther.text = ruleDetails['param4'] ?? '';
//   //           break;
//   //
//   //         case 13:
//   //           workingDaysController.text = ruleDetails['param1'] ?? '';
//   //           leaveDaysController.text = ruleDetails['param2'] ?? '';
//   //
//   //           break;
//   //         case 14:
//   //           unitsProducedController.text = ruleDetails['param1'] ?? '';
//   //           unitRateController.text = ruleDetails['param2'] ?? '';
//   //           workingDaysWeekController.text = ruleDetails['param3'] ?? '';
//   //           break;
//   //
//   //         case 15:
//   //           latePenaltyPerOccurrenceController.text = ruleDetails['param1'] ?? '';
//   //
//   //           break;
//   //
//   //         case 16:
//   //           earlyPenaltyPerOccurrenceController.text = ruleDetails['param1'] ?? '';
//   //
//   //           break;
//   //
//   //         case 18:
//   //           hourlyRateController.text = ruleDetails['param2'] ?? '';
//   //
//   //           break;
//   //
//   //         case 19:
//   //           graceHourController.text = ruleDetails['param1'] ?? '';
//   //           fixedPenaltyController.text = ruleDetails['param2'] ?? '';
//   //
//   //           break;
//   //
//   //         case 20:
//   //           incrementalController.text = ruleDetails['param1'] ?? '';
//   //           break;
//   //
//   //         case 21:
//   //           dayShiftController.text = ruleDetails['param1'] ?? '';
//   //           nightShiftController.text = ruleDetails['param2'] ?? '';
//   //
//   //           break;
//   //
//   //         case 22:
//   //           costPerMissedPunch.text = ruleDetails['param1'] ?? '';
//   //           missAcceptableTime.text = ruleDetails['param2'] ?? '';
//   //
//   //           break;
//   //
//   //       // case 23:
//   //       //   costPerMissedPunchAmount.text = ruleDetails['param1'] ?? '';
//   //       //   deductedForOneDay.text = ruleDetails['param2'] ?? '';
//   //       //
//   //       //   if (costPerMissedPunchAmount.text.isNotEmpty) {
//   //       //     selectedOption = 0;
//   //       //     isCostPerMissedSelected = true;
//   //       //     isDeductedDaySalarySelected = false;
//   //       //   } else if (deductedForOneDay.text.isNotEmpty) {
//   //       //     selectedOption = 1;
//   //       //     isCostPerMissedSelected = false;
//   //       //     isDeductedDaySalarySelected = true;
//   //       //   }
//   //       //   break;
//   //
//   //         case 23:
//   //           _overtime = ruleDetails['param1']?.isNotEmpty == true ? bool.parse(ruleDetails['param1']!) : false;
//   //           _overtimeRateController.text = ruleDetails['param2'] ?? '';
//   //
//   //           break;
//   //
//   //         default:
//   //         // Handle default case if needed
//   //           break;
//   //       }
//   //     });
//   //   }
//   // }
//
//   // Function to convert a time string to TimeOfDay
//   TimeOfDay parseTimeString(String time) {
//     // Regular expression to match the time string (e.g., 09:00 or 15:30)
//     final RegExp timeRegExp = RegExp(r'^(\d{1,2}):(\d{2})$');
//     final Match? match = timeRegExp.firstMatch(time);
//
//     if (match != null) {
//       // Extract the hour and minute
//       int hour = int.parse(match.group(1)!);
//       int minute = int.parse(match.group(2)!);
//
//       // Ensure hour is within valid range
//       if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
//         throw FormatException("Invalid time value: $time");
//       }
//
//       return TimeOfDay(hour: hour, minute: minute);
//     } else {
//       // Handle invalid input: you can throw an error, return a default value, or null
//       throw FormatException("Invalid time format: $time");
//     }
//   }
//
//   final List<String> weekdays = [
//     'Monday',
//     'Tuesday',
//     'Wednesday',
//     'Thursday',
//     'Friday',
//     'Saturday',
//     'Sunday',
//   ];
//
//   // Future<void> _saveRule(
//   //     {String p1 = '', String p2 = '', String p3 = '', String p4 = '', String p5 = '', String p6 = ""}) async {
//   //   final insertRule = {
//   //     'empId': widget.empId,
//   //     'ruleId': widget.ruleId, // Use the index as the rule ID
//   //     // 'ruleStatus': 0, // Replace with actual status if needed
//   //     'param1': p1, // Replace with actual value
//   //     'param2': p2, // Replace with actual value
//   //     'param3': p3, // Replace with actual value
//   //     'param4': p4, // Replace with actual value
//   //     'param5': p5, // Replace with actual value
//   //     'param6': p6, // Replace with actual value
//   //   };
//   //
//   //   await databaseHelper.insertOrUpdateRule(insertRule);
//   //
//   //   DSnackBar.successSnackBar(title: AppLocalizations.of(context)!.rulesAddedSuccessfully);
//   //
//   //   Navigator.pop(context);
//   // }
//
//   @override
//   void dispose() {
//     workingDaysController.dispose();
//     leaveDaysController.dispose();
//     latePenaltyPerOccurrenceController.dispose();
//     earlyPenaltyPerOccurrenceController.dispose();
//     unitRateController.dispose();
//     unitsProducedController.dispose();
//     hourlyRateController.dispose();
//     fixedPenaltyController.dispose();
//     dayShiftController.dispose();
//     nightShiftController.dispose();
//     lastLateTimeController.dispose();
//     costPerMissedPunch.dispose();
//     missAcceptableTime.dispose();
//     costPerMissedPunchAmount.dispose();
//     deductedForOneDay.dispose();
//     minutesLater.dispose();
//     laterTime.dispose();
//     costOvertime.dispose();
//     overtimeWillNotBeCountedUntil.dispose();
//     lateTime.dispose();
//     enterLeaveDay.dispose();
//     enterLeaveDayCost.dispose();
//
//     super.dispose();
//   }
//
//   // List<String> _getLocalizedWeekdays() {
//   //   return [
//   //     AppLocalizations.of(context)!.monday,
//   //     AppLocalizations.of(context)!.tuesday,
//   //     AppLocalizations.of(context)!.wednesday,
//   //     AppLocalizations.of(context)!.thursday,
//   //     AppLocalizations.of(context)!.friday,
//   //     AppLocalizations.of(context)!.saturday,
//   //     AppLocalizations.of(context)!.sunday,
//   //   ];
//   // }
//
//   final ValueNotifier<String?> cutsalaryValueChange = ValueNotifier<String?>(null);
//
//   @override
//   Widget build(BuildContext context) {
//     final dTexts = Theme.of(context).textTheme;
//     final List<String> askForLeave = [
//
//     ];
//     final localizedWeekdays = ["satarday","sunday"];
//
//
//
//
//     Widget content;
//
//     if (widget.ruleId == 0) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.rule, style: dTexts.titleSmall),
//           SizedBox(height: 16),
//           ListTile(
//             leading: Image.asset('assets/icons/Group_259.png', width: 24.0, height: 24.0),
//             title: Text("am working time", style: dTexts.bodyLarge),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('${_formatTimeOfDay(selectedAMStartTime)} - ${_formatTimeOfDay(selectedAMEndTime)}',
//                     style: dTexts.bodyLarge),
//                 const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 24),
//               ],
//             ),
//             onTap: () {
//               _showWorkTimeDialog(context, 'AM');
//             },
//           ),
//           SizedBox(height: 16),
//           ListTile(
//             leading: Image.asset('assets/icons/Group_259.png', width: 24.0, height: 24.0),
//             title: Text("pm working time", style: dTexts.bodyLarge),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('${_formatTimeOfDay(selectedPMStartTime)} - ${_formatTimeOfDay(selectedPMEndTime)}',
//                     style: dTexts.bodyLarge),
//                 const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 24),
//               ],
//             ),
//             onTap: () {
//               _showWorkTimeDialog(context, 'PM');
//             },
//           ),
//           SizedBox(height: 16),
//           ListTile(
//             leading: Image.asset('assets/icons/Group_259.png', width: 25.0, height: 25.0),
//             title: Text("Over working time", style: dTexts.bodyLarge),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   '${_formatTimeOfDay(selectedOverStartTime)} - ${_formatTimeOfDay(selectedOverEndTime)}',
//                   style: dTexts.bodyLarge,
//                 ),
//                 const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 24),
//               ],
//             ),
//             onTap: () {
//               _showWorkTimeDialog(context, 'Over');
//             },
//           ),
//           SizedBox(height: 16),
//           Text("details", style: dTexts.titleSmall),
//           Text.rich(
//             textScaler: TextScaler.linear(1),
//             TextSpan(
//               text: '\n Time for the start\n'
//                   '\nFron after tea break\n'
//                   '\nOvertime after time finish',
//             ),
//             style: dTexts.bodyMedium,
//             textAlign: TextAlign.start,
//           ),
//           SizedBox(height: 16),
//           Center(
//             child: PrimaryButton(
//                 height: 44.sp,
//                 onPressed: () {
//
//                 },
//                 tittleText: Text("save")),
//           ),
//         ],
//       );
//     } else if (widget.ruleId == 1) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.rule, style: dTexts.titleSmall),
//           SizedBox(height: 16),
//           SizedBox(
//             height: 450.h, // Set your desired fixed height here
//             child: CalendarCarousel<Event>(
//               iconColor: DColors.primary,
//               disableDayPressed: false,
//               onDayPressed: (date, events) => _onHolyDayPressed(date, events),
//               //todayBorderColor:  DColors.primary,
//               todayButtonColor: Colors.transparent,
//               locale: LocalData.languageCode,
//               todayTextStyle: const TextStyle(color: Colors.black),
//               markedDatesMap: EventList<Event>(
//                 events: {
//                   for (var date in _selectedHolidays)
//                     date: [
//                       Event(
//                         date: date,
//                         title: 'Holiday',
//                         dot: const Icon(Icons.circle, size: 5.0, color: DColors.primary),
//                       ),
//                     ]
//                 },
//               ),
//               markedDateShowIcon: true,
//               minSelectedDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
//               maxSelectedDate: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
//               markedDateIconBuilder: (event) {
//                 return Container(
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: DColors.primary, // Customize the icon background color
//                   ),
//                   child: Center(
//                     child: Text(
//                       event.date.day.toString(), // Display the day of the date
//                       style: const TextStyle(color: Colors.white), // Customize the text style
//                     ),
//                   ),
//                 );
//               },
//               weekdayTextStyle: const TextStyle(color: DColors.primary), // Customize weekday text color
//               weekendTextStyle: const TextStyle(color: Colors.black), // Customize weekend text color
//               // Customize other properties as needed
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Text.rich(
//             TextSpan(
//               children: <TextSpan>[
//                 TextSpan(
//                   text: '${AppLocalizations.of(context)!.details} \n\n',
//                   style: dTexts.titleSmall,
//                 ),
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.hereYouCanSelectHolidays,
//                 ),
//               ],
//             ),
//             style: dTexts.bodyMedium,
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Center(
//             child: PrimaryButton(
//                 height: DSizes.buttonHeight,
//                 onPressed: () {
//                   DSnackBar.successSnackBar(title: AppLocalizations.of(context)!.rulesAddedSuccessfully);
//                   Navigator.of(context).pop();
//                 },
//                 tittleText: Text(AppLocalizations.of(context)!.save)),
//           ),
//         ],
//       );
//     } else if (widget.ruleId == 2) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.rule, style: dTexts.titleSmall),
//           ...List.generate(weekdays.length, (index) {
//             return Row(
//               children: [
//                 Checkbox(
//                   value: daysChecked[index],
//                   onChanged: (bool? value) {
//                     if (value == true && daysChecked.where((day) => day).length >= 5) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                             AppLocalizations.of(context)!.youCanSelect,
//                           ),
//                         ),
//                       );
//                       return;
//                     }
//                     setState(() {
//                       daysChecked[index] = value ?? false;
//                     });
//                   },
//                 ),
//                 Text(localizedWeekdays[index]),
//               ],
//             );
//           }),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           Text.rich(
//               TextSpan(text: '\n• ${AppLocalizations.of(context)!.confirmThatTheCompany}\n', style: dTexts.bodyMedium)),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Center(
//               child: PrimaryButton(
//                   height: DSizes.buttonHeight,
//                   onPressed: () => _saveSelectedDays(),
//                   tittleText: Text(AppLocalizations.of(context)!.save))),
//         ],
//       );
//     } else if (widget.ruleId == 3) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.rule, style: dTexts.titleSmall),
//           SizedBox(height: DSizes.spaceBtwItems),
//           SizedBox(
//             height: 500.h,
//             child: CalendarCarousel<Event>(
//               onDayPressed: _onGeneralDayPressed,
//               todayBorderColor: Colors.transparent, // Remove today's border color
//               todayButtonColor: Colors.transparent, // Remove today's button color
//               locale: LocalData.languageCode,
//               minSelectedDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
//               maxSelectedDate: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
//               iconColor: DColors.primary,
//               todayTextStyle: const TextStyle(color: Colors.black), // Customize today's text style
//               markedDatesMap: EventList<Event>(
//                 events: {
//                   for (var date in _selectGeneralDays)
//                     date: [
//                       Event(
//                         date: date,
//                         title: 'Holiday As General Day',
//                         dot: const Icon(Icons.circle, size: 5.0, color: DColors.primary),
//                       ),
//                     ]
//                 },
//               ),
//               markedDateShowIcon: true,
//               markedDateIconBuilder: (event) {
//                 return Container(
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: DColors.primary,
//                   ),
//                   child: Center(
//                     child: Text(
//                       event.date.day.toString(),
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 );
//               },
//               weekdayTextStyle: const TextStyle(color: DColors.primary),
//               weekendTextStyle: const TextStyle(color: Colors.black),
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Text(AppLocalizations.of(context)!.hereIfYouHaveWorkedOnWeekends, style: dTexts.bodyMedium),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveSelectedDays();
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save)),
//         ],
//       );
//     } else if (widget.ruleId == 4) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.rule, style: dTexts.titleSmall),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(
//                   AppLocalizations.of(context)!.lastTimeOfCountLet,
//                   style: dTexts.bodyLarge,
//                 ),
//               ),
//               SizedBox(
//                 width: 200.h,
//                 child: TextField(
//                   controller: lastLateTimeController,
//                   keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                   decoration: InputDecoration(
//                     labelText: AppLocalizations.of(context)!.enterLastTimeOfLetCount,
//                     //border: const OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           Text.rich(
//             style: dTexts.bodyMedium,
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.latenessWarningSystem}'
//                   '\n\n ',
//               children: <TextSpan>[
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.example,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.latenessWillBeCounted,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(p1: lastLateTimeController.text);
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save)),
//         ],
//       );
//     } else if (widget.ruleId == 5) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.rule, style: dTexts.titleSmall),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(width: 100, child: Text(AppLocalizations.of(context)!.minutesLater, style: dTexts.bodyLarge)),
//               SizedBox(width: 10.h),
//               SizedBox(
//                 width: 200.h,
//                 child: TextField(
//                   controller: minutesLater,
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   decoration: InputDecoration(labelText: AppLocalizations.of(context)!.howManyMinutesLater),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(width: 100, child: Text(AppLocalizations.of(context)!.goAfterMinutes)),
//               SizedBox(width: 10.h),
//               SizedBox(
//                 width: 200.h,
//                 child: TextField(
//                   controller: goAfterMinutes,
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   decoration: InputDecoration(
//                     labelText: AppLocalizations.of(context)!.enterHowManyMinutes,
//                     border: const OutlineInputBorder(),
//                     floatingLabelBehavior: FloatingLabelBehavior.never,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Text.rich(
//             style: dTexts.bodyMedium,
//             TextSpan(
//               text: '• ${AppLocalizations.of(context)!.comeToWork}'
//                   '\n',
//               children: <TextSpan>[
//                 TextSpan(text: "\n${AppLocalizations.of(context)!.example}"),
//                 TextSpan(text: AppLocalizations.of(context)!.arrive5MinutesLate),
//               ],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(p1: minutesLater.text, p2: goAfterMinutes.text);
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     } else if (widget.ruleId == 6) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.rule, style: dTexts.titleSmall),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(width: 100.h, child: Text(AppLocalizations.of(context)!.laterTime, style: dTexts.bodyLarge)),
//               SizedBox(width: 10.h),
//               SizedBox(
//                 width: 200.h,
//                 child: TextField(
//                   controller: lateTime,
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   decoration: InputDecoration(labelText: AppLocalizations.of(context)!.howManyMinutesLater),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(
//                   AppLocalizations.of(context)!.costOverTime,
//                   style: dTexts.bodyLarge,
//                 ),
//               ),
//               SizedBox(width: 10.h),
//               SizedBox(
//                 width: 200.h,
//                 child: TextField(
//                   controller: costOvertime,
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   decoration: InputDecoration(
//                     labelText: AppLocalizations.of(context)!.enterCostOverTimeMinutes,
//                     border: const OutlineInputBorder(),
//                     floatingLabelBehavior: FloatingLabelBehavior.never,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           Text.rich(
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.ifYouArriveLate}'
//                   '\n'
//                   '\n',
//               children: <TextSpan>[
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.example,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.firstYourHoliday,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(p1: lateTime.text, p2: costOvertime.text);
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     } else if (widget.ruleId == 7) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.rule,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.overtimeWillNotBeCountedUntil),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: SizedBox(
//                   width: 200.h,
//                   child: TextField(
//                     controller: overtimeWillNotBeCountedUntil,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(
//                       labelText: AppLocalizations.of(context)!.overtimeWillNotBeCountedUntil,
//                       border: const OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           SizedBox(height: 10.h),
//           Text.rich(
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.howLongAfterOvertime}'
//                   '\n'
//                   '\n',
//               children: <TextSpan>[
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.example,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.asYouHaveFixed,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(p1: overtimeWillNotBeCountedUntil.text);
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     } else if (widget.ruleId == 8) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.rule,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.weekendOvertimePercent),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: SizedBox(
//                   width: 200.h,
//                   child: TextField(
//                     controller: weekendOvertimeController,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(
//                       labelText: AppLocalizations.of(context)!.enterWeekendOvertimePercent,
//                       border: const OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           SizedBox(height: 10.h),
//           Text.rich(
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.hoursWorkedOnWeekends}'
//                   '\n\n• ',
//               children: <TextSpan>[
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.example,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextSpan(
//                     text:
//                     '${AppLocalizations.of(context)!.anEmployeeWorks} \n\n ${AppLocalizations.of(context)!.overtimePayEx}'),
//               ],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(
//                   p1: weekendOvertimeController.text,
//                 );
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     } else if (widget.ruleId == 9) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.rule,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.holidayOvertimePercent),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: SizedBox(
//                   width: 200.h,
//                   child: TextField(
//                     controller: holidayOvertimeController,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(
//                       labelText: AppLocalizations.of(context)!.enterHolidayOverTimePercent,
//                       border: const OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           SizedBox(height: 10.h),
//           Text.rich(
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.hoursWorkedOnRecognized}'
//                   '\n\n• ',
//               children: <TextSpan>[
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.example,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextSpan(
//                   text:
//                   '${AppLocalizations.of(context)!.anEmployeeWorks8Hours} \n ${AppLocalizations.of(context)!.overtimePayEx2}',
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(
//                   p1: holidayOvertimeController.text,
//                 );
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     } else if (widget.ruleId == 10) {
//       content = SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.rule,
//               style: dTexts.titleSmall,
//             ),
//             ...List.generate(askForLeave.length, (index) {
//               return Row(
//                 children: [
//                   Checkbox(
//                     value: showCalendarList[index],
//                     onChanged: (bool? value) {
//                       setState(() {
//                         daysChecked[index] = value ?? false;
//                         showCalendarList[index] = value!;
//                       });
//                     },
//                   ),
//                   Text(askForLeave[index]),
//                 ],
//               );
//             }),
//             Row(
//               children: [
//                 Checkbox(
//                   value: isSickLeaveSelected,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       isSickLeaveSelected = value!;
//                       showCalendar = value; // Toggle calendar visibility
//                     });
//                   },
//                 ),
//                 Text(AppLocalizations.of(context)!.sickLeave),
//               ],
//             ),
//             if (isSickLeaveSelected) ...[
//               SizedBox(width: 10.h),
//               Row(
//                 children: [
//                   Radio(
//                     value: 0,
//                     groupValue: selectedRadioIndex2,
//                     onChanged: (int? value) {
//                       setState(() {
//                         selectedRadioIndex2 = value!;
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width / 3.2,
//                     child: TextField(
//                       controller: enterLeaveDay,
//                       keyboardType: TextInputType.numberWithOptions(decimal: true),
//                       decoration: InputDecoration(
//                         labelText: AppLocalizations.of(context)!.leaveDay,
//                         border: const OutlineInputBorder(),
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                       ),
//                     ),
//                   ),
//                   Radio(
//                     value: 1,
//                     groupValue: selectedRadioIndex2,
//                     onChanged: (int? value) {
//                       setState(() {
//                         selectedRadioIndex2 = value!;
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width / 3.2,
//                     child: TextField(
//                       controller: enterLeaveDayCost,
//                       keyboardType: TextInputType.numberWithOptions(decimal: true),
//                       decoration: InputDecoration(
//                         labelText: AppLocalizations.of(context)!.dayCost,
//                         border: const OutlineInputBorder(),
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//             Row(
//               children: [
//                 Checkbox(
//                   value: isCOthersSelected,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       isCOthersSelected = value!;
//                       showCalendar2 = value; // Toggle calendar visibility
//                     });
//                   },
//                 ),
//                 Text(AppLocalizations.of(context)!.others),
//               ],
//             ),
//             if (isCOthersSelected) ...[
//               SizedBox(width: 10.h),
//               Row(
//                 children: [
//                   Radio(
//                     value: 0,
//                     groupValue: selectedRadioIndex,
//                     onChanged: (int? value) {
//                       setState(() {
//                         selectedRadioIndex = value!;
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width / 3.2,
//                     child: TextField(
//                       controller: enterLeaveDayOther,
//                       keyboardType: TextInputType.numberWithOptions(decimal: true),
//                       decoration: InputDecoration(
//                         labelText: AppLocalizations.of(context)!.leaveDay,
//                         border: const OutlineInputBorder(),
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                       ),
//                     ),
//                   ),
//                   Radio(
//                     value: 1,
//                     groupValue: selectedRadioIndex,
//                     onChanged: (int? value) {
//                       setState(() {
//                         selectedRadioIndex = value!;
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width / 3.2,
//                     child: TextField(
//                       controller: enterLeaveDayCostOther,
//                       keyboardType: TextInputType.numberWithOptions(decimal: true),
//                       decoration: InputDecoration(
//                         labelText: AppLocalizations.of(context)!.dayCost,
//                         border: const OutlineInputBorder(),
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//             SizedBox(height: 30.h),
//             Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//             SizedBox(height: 10.h),
//             Text.rich(
//               TextSpan(
//                   text: '\n• ${AppLocalizations.of(context)!.hereIfYouApplyForLeave} \n'
//                       '\n• ${AppLocalizations.of(context)!.butThereAreSick} \n'),
//             ),
//             SizedBox(height: DSizes.spaceBtwItems),
//             PrimaryButton(
//                 height: DSizes.buttonHeight,
//                 onPressed: () {
//                   _saveRule(
//                     p1: enterLeaveDay.text.isNotEmpty ? enterLeaveDay.text : '0',
//                     p2: enterLeaveDayCost.text.isNotEmpty ? enterLeaveDayCost.text : '0',
//                     p3: enterLeaveDayOther.text.isNotEmpty ? enterLeaveDayOther.text : '0',
//                     p4: enterLeaveDayCostOther.text.isNotEmpty ? enterLeaveDayCostOther.text : '0',
//                   );
//                 },
//                 tittleText: Text(AppLocalizations.of(context)!.save)),
//             SizedBox(width: 10.h),
//             for (var index = 0; index < askForLeave.length; index++)
//               if (showCalendarList[index])
//                 Column(
//                   children: [
//                     SizedBox(
//                       height: 20.h,
//                       child: Text(askForLeave[index].toString()),
//                     ),
//                     SizedBox(
//                       height: 500.h,
//                       child: CalendarCarousel<Event>(
//                         onDayPressed: (date, events) => _handleDayPressed(date, events, index),
//                         pageScrollPhysics: const NeverScrollableScrollPhysics(),
//                         todayBorderColor: Colors.transparent,
//                         todayButtonColor: Colors.transparent,
//                         locale: LocalData.languageCode,
//                         iconColor: DColors.primary,
//                         minSelectedDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
//                         maxSelectedDate: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
//                         todayTextStyle: const TextStyle(color: Colors.black),
//                         markedDatesMap: _buildMarkedDatesMap(askForLeave[index].toString()),
//                         markedDateShowIcon: true,
//                         markedDateIconBuilder: (event) {
//                           return Container(
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: DColors.primary,
//                             ),
//                             child: Center(
//                               child: Text(
//                                 event.date.day.toString(),
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           );
//                         },
//                         weekdayTextStyle: const TextStyle(color: DColors.primary),
//                         weekendTextStyle: const TextStyle(color: Colors.black),
//                       ),
//                     ),
//                     SizedBox(height: 20.h),
//                   ],
//                 ),
//             if (showCalendar) ...[
//               SizedBox(
//                 height: 400.0.h,
//                 child: CalendarCarousel<Event>(
//                   onDayPressed: (date, events) => _onSickDayPressed(date, events),
//                   pageScrollPhysics: const NeverScrollableScrollPhysics(),
//                   todayBorderColor: Colors.transparent,
//                   todayButtonColor: Colors.transparent,
//                   locale: LocalData.languageCode,
//                   minSelectedDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
//                   maxSelectedDate: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
//                   iconColor: DColors.primary,
//                   todayTextStyle: const TextStyle(color: Colors.black),
//                   markedDatesMap: EventList<Event>(
//                     events: {
//                       for (var date in _sickLeave)
//                         date: [
//                           Event(
//                             date: date,
//                             title: 'Selected Holiday',
//                             dot: const Icon(Icons.circle, size: 5.0, color: DColors.primary),
//                           ),
//                         ]
//                     },
//                   ),
//                   markedDateShowIcon: true,
//                   markedDateIconBuilder: (event) {
//                     return Container(
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: DColors.primary,
//                       ),
//                       child: Center(
//                         child: Text(
//                           event.date.day.toString(),
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     );
//                   },
//                   weekdayTextStyle: const TextStyle(color: DColors.primary),
//                   weekendTextStyle: const TextStyle(color: Colors.black),
//                 ),
//               ),
//             ],
//             if (showCalendar2) ...[
//               SizedBox(
//                 height: 500.0.h,
//                 child: CalendarCarousel<Event>(
//                   pageScrollPhysics: const NeverScrollableScrollPhysics(),
//                   onDayPressed: (date, events) => _onOtherDayPressed(date, events),
//                   todayBorderColor: Colors.transparent,
//                   todayButtonColor: Colors.transparent,
//
//                   minSelectedDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
//                   maxSelectedDate: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
//                   locale: LocalData.languageCode,
//                   todayTextStyle: const TextStyle(color: Colors.black),
//                   markedDatesMap: EventList<Event>(
//                     events: {
//                       for (var date in _otherLeave)
//                         date: [
//                           Event(
//                             date: date,
//                             title: 'Selected Others Holiday',
//                             dot: const Icon(Icons.circle, size: 5.0, color: DColors.primary),
//                           ),
//                         ]
//                     },
//                   ),
//                   markedDateShowIcon: true,
//                   markedDateIconBuilder: (event) {
//                     return Container(
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: DColors.primary,
//                       ),
//                       child: Center(
//                         child: Text(
//                           event.date.day.toString(),
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     );
//                   },
//                   weekdayTextStyle: const TextStyle(color: DColors.primary),
//                   weekendTextStyle: const TextStyle(color: Colors.black),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       );
//     } else if (widget.ruleId == 11) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Rule Title
//           Text(widget.rule, style: dTexts.titleSmall),
//
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//             decoration: BoxDecoration(
//               color: Colors.grey[50],
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//             child: ListTile(
//               dense: true,
//               leading: Icon(Icons.calendar_month),
//               title: Text('Select Date', style: dTexts.bodyMedium),
//               trailing: GestureDetector(
//                 onTap: () async {
//                   await _showMonthYearPickerDialog(context, setState);
//                 },
//                 child: SizedBox(
//                   width: 150.w, // Adjust width as needed
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end, // Align to the right
//                     children: [
//                       Text(
//                         selectDate == null
//                             ? AppLocalizations.of(context)!.selectDate
//                             : DateFormat('yyyy-MM-dd').format(selectDate!),
//                         style: const TextStyle(fontSize: 16, color: Colors.black),
//                       ),
//                       const Icon(Icons.keyboard_arrow_right_outlined),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 10.h),
//
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   AppLocalizations.of(context)!.cutSalary,
//                   style: dTexts.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
//                 ),
//                 Row(
//                   children: [
//                     Radio<bool>(
//                       value: true,
//                       groupValue: cutSalary,
//                       onChanged: (value) {
//                         setState(() {
//                           cutSalary = value!;
//                           cutsalaryValueChange.value = value.toString(); // Update value notifier
//                         });
//                       },
//                     ),
//                     Text(AppLocalizations.of(context)!.yes),
//                     SizedBox(width: 20.w),
//                     Radio<bool>(
//                       value: false,
//                       groupValue: cutSalary,
//                       onChanged: (value) {
//                         setState(() {
//                           cutSalary = value!;
//                           cutsalaryValueChange.value = value.toString(); // Update value notifier
//                         });
//                       },
//                     ),
//                     Text(AppLocalizations.of(context)!.no),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 10.h),
//
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   AppLocalizations.of(context)!.selectImage,
//                   style: dTexts.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
//                 ),
//                 Row(
//                   children: [
//                     if (selectedImageFile != null) // Show image if available
//                       Container(
//                         width: 50.w,
//                         height: 50.h,
//                         margin: EdgeInsets.only(right: 12.w),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.r),
//                           image: DecorationImage(
//                             image: FileImage(selectedImageFile!),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     IconButton(
//                       onPressed: _pickImage,
//                       icon: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.upload_file_outlined),
//                           Text(
//                             AppLocalizations.of(context)!.signature,
//                             style: TextStyle(fontSize: 12), // Adjust font size if needed
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           if (_selectMissPunchDocuments.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     AppLocalizations.of(context)!.document,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xffb004368),
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height / 3.5,
//                     child: ListView.builder(
//                       itemCount: _selectMissPunchDocuments.length,
//                       itemBuilder: (context, index) {
//                         final document = _selectMissPunchDocuments[index];
//                         return Container(
//                           decoration: BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(
//                                 color: Theme.of(context).primaryColor.withOpacity(0.2),
//                                 width: 2.0,
//                               ),
//                             ),
//                           ),
//                           child: ListTile(
//                             leading: Icon(Icons.picture_as_pdf, color: Theme.of(context).primaryColor),
//                             title: Text('${AppLocalizations.of(context)!.document} ${index + 1}: ${document['date']}'),
//                             subtitle: Text('${AppLocalizations.of(context)!.cutSalary} : '
//                                 '${document['CutSalary'] == "Yes" ? AppLocalizations.of(context)!.yes : AppLocalizations.of(context)!.no}'),
//                             trailing: IconButton(
//                               icon: Icon(Icons.delete, color: Theme.of(context).primaryColor.withOpacity(0.8)),
//                               onPressed: () async {
//                                 await databaseHelper.deletePunchDocumentByDate(document['date']);
//                                 setState(() {
//                                   _loadDocuments();
//                                 });
//                               },
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           else
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10.0),
//               child: Text(AppLocalizations.of(context)!.noDocument),
//             ),
//
//           // Details Section
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   AppLocalizations.of(context)!.details,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xffb004368),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text.rich(
//                   TextSpan(
//                     text: '\n• ${AppLocalizations.of(context)!.youCanUpload}\n\n',
//                     children: [
//                       TextSpan(
//                         text: AppLocalizations.of(context)!.example,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       TextSpan(
//                         text: AppLocalizations.of(context)!.ifSomeoneCameToTheInstitution,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: _saveDocument,
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     } else if (widget.ruleId == 12) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.rule,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 20.h),
//           Container(
//             child: _selectReplaceDays.isNotEmpty
//                 ? DataTable(
//               columns: <DataColumn>[
//                 DataColumn(
//                   label: Text(
//                     AppLocalizations.of(context)!.sL,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     AppLocalizations.of(context)!.date,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ],
//               rows: List<DataRow>.generate(
//                 _selectReplaceDays.length,
//                     (index) => DataRow(
//                   cells: <DataCell>[
//                     DataCell(Text((index + 1).toString())),
//                     DataCell(Text(
//                       '${_selectReplaceDays[index].day}/${_selectReplaceDays[index].month}/${_selectReplaceDays[index].year}',
//                     )),
//                   ],
//                 ),
//               ),
//             )
//                 : Text(
//               AppLocalizations.of(context)!.youDontHaveAnyReplacementDays,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//             ),
//           ),
//           SizedBox(height: 20.h),
//           Text(
//             AppLocalizations.of(context)!.date,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 10.h),
//           Text.rich(
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.hereYourReplacementDates}'
//                   '\n',
//             ),
//           ),
//         ],
//       );
//     } else if (widget.ruleId == 13) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.rule,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.leaveDay),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: TextField(
//                   controller: leaveDaysController,
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   decoration: InputDecoration(
//                     labelText: AppLocalizations.of(context)!.enterLeaveDays,
//                     border: const OutlineInputBorder(),
//                     floatingLabelBehavior: FloatingLabelBehavior.never,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Text(
//             AppLocalizations.of(context)!.details,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Color(0xffb004368),
//             ),
//           ),
//           SizedBox(height: 10.h),
//           Text.rich(
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.calculateTheDailyRate}'
//                   '\n• ${AppLocalizations.of(context)!.deductDaysPayFor}'
//                   '\n ',
//               children: <TextSpan>[],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(p1: workingDaysController.text, p2: leaveDaysController.text);
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     }
//     //ruleId 14 is missing
//
//     else if (widget.ruleId == 15) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.rule,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.latePenalty),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: SizedBox(
//                   width: 200.h,
//                   child: TextField(
//                     controller: latePenaltyPerOccurrenceController,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(
//                       labelText: AppLocalizations.of(context)!.penaltyPerOccurrence,
//                       border: const OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           SizedBox(height: 10.h),
//           Text.rich(
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.deductPenaltyForLate}'
//                   '\n• ',
//               children: <TextSpan>[
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.example,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextSpan(
//                   text: ' ${AppLocalizations.of(context)!.ifAnEmployeeMonthlySalary}'
//                       '\n\n ${AppLocalizations.of(context)!.totalPenaltyEx}'
//                       '\n\n ${AppLocalizations.of(context)!.totalPayEx}',
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(p1: latePenaltyPerOccurrenceController.text);
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     } else if (widget.ruleId == 16) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.rule,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.earlyDeparturePenalty),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: SizedBox(
//                   width: 200.h,
//                   child: TextField(
//                     controller: earlyPenaltyPerOccurrenceController,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(
//                       labelText: AppLocalizations.of(context)!.penaltyPerOccurrence,
//                       border: const OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           SizedBox(height: 10.h),
//           Text.rich(
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.deductFixedAmount}'
//                   '\n• ',
//               children: <TextSpan>[
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.example,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextSpan(
//                   text: '${AppLocalizations.of(context)!.ifEarlyDepartureDeduction}'
//                       '\n\n ${AppLocalizations.of(context)!.totalPenaltyEx2}'
//                       '\n\n ${AppLocalizations.of(context)!.totalPayEx2}',
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(p1: earlyPenaltyPerOccurrenceController.text);
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     } else if (widget.ruleId == 17) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.rule,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 20.h),
//           Text(
//             AppLocalizations.of(context)!.lateHalfDayCostHalf,
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xffb004368)),
//           ),
//           SizedBox(height: 20.h),
//           Text(
//             AppLocalizations.of(context)!.lateHalfDayCostFull,
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xffb004368)),
//           ),
//           SizedBox(height: 20.h),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           SizedBox(height: 10.h),
//           Text.rich(
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.ifHeComesBeforeHalfDay}'
//                   '\n ${AppLocalizations.of(context)!.ifHeComesAfterHalfDay}'
//                   '\n'
//                   '\n',
//               children: <TextSpan>[
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.example,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.supposeYourCompanyRuns,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(p1: lateTime.text, p2: costOvertime.text);
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     } else if (widget.ruleId == 18) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.rule,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.lateTime),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: SizedBox(
//                   width: 200.h,
//                   child: const TextField(
//                     // controller: hourlyLateTime,
//                     enabled: false,
//                     //keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: '1',
//                       border: OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.hourlyLateRate),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: SizedBox(
//                   width: 200.h,
//                   child: TextField(
//                     controller: hourlyRateController,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(
//                       labelText: AppLocalizations.of(context)!.everyHourlyRate,
//                       border: const OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           SizedBox(height: 10.h),
//           Text.rich(
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.deductHourlyRateForEach}'
//                   '\n• ',
//               children: <TextSpan>[
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.example,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.ifHourlyRateIs10,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(p1: '1', p2: hourlyRateController.text);
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     } else if (widget.ruleId == 19) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.rule,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.latenessHours),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: SizedBox(
//                   width: 200.h,
//                   child: TextField(
//                     controller: graceHourController,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(
//                       labelText: AppLocalizations.of(context)!.totalLatenessMinute,
//                       border: const OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.fixedPenalty),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: SizedBox(
//                   width: 200.h,
//                   child: TextField(
//                     controller: fixedPenaltyController,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(
//                       labelText: AppLocalizations.of(context)!.fixedPenalty,
//                       border: const OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           SizedBox(height: 10.h),
//           Text.rich(
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.implementNoTolerancePolicy}'
//                   '\n• ',
//               children: <TextSpan>[
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.example,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextSpan(
//                   text: '${AppLocalizations.of(context)!.ifAnEmployeeExceedsTotal}'
//                       '\n\n ${AppLocalizations.of(context)!.totalPenaltyEx3}'
//                       '\n\n ${AppLocalizations.of(context)!.totalPayEx3}',
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(p1: graceHourController.text, p2: fixedPenaltyController.text);
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     } else if (widget.ruleId == 20) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.rule,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.incrementalValue),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: SizedBox(
//                   width: 200.h,
//                   child: TextField(
//                     controller: incrementalController,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(
//                       labelText: AppLocalizations.of(context)!.incrementPerLate,
//                       border: const OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           SizedBox(height: 10.h),
//           Text.rich(
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.applyIncrementalPenalty}\n'
//                   '\n• ',
//               children: <TextSpan>[
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.example,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextSpan(text: ': ${AppLocalizations.of(context)!.deduct$10For} '),
//               ],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(p1: incrementalController.text);
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     } else if (widget.ruleId == 21) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.rule,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.dayShift),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: SizedBox(
//                   width: 200.h,
//                   child: TextField(
//                     controller: dayShiftController,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(
//                       labelText: AppLocalizations.of(context)!.dayShiftDeduction,
//                       border: const OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.nightShift),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: SizedBox(
//                   width: 200.h,
//                   child: TextField(
//                     controller: nightShiftController,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(
//                       labelText: AppLocalizations.of(context)!.nightShiftDeduction,
//                       border: const OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           SizedBox(height: 10.h),
//           Text.rich(
//             TextSpan(
//               text: '\n\n• ${AppLocalizations.of(context)!.applyDifferentLateness}\n'
//                   '\n• ',
//               children: <TextSpan>[
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.example,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextSpan(
//                   text: '${AppLocalizations.of(context)!.ifEmployeeMonthlySalaryIs2000}\n'
//                       '\n\n ${AppLocalizations.of(context)!.totalPenaltyEx4}\n'
//                       '\n\n ${AppLocalizations.of(context)!.totalPenaltyEx5}\n'
//                       '\n\n ${AppLocalizations.of(context)!.totalPayEx4}\n'
//                       '\n\n ${AppLocalizations.of(context)!.totalPayEx5}',
//                 ),
//               ],
//             ),
//           ),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(p1: dayShiftController.text, p2: nightShiftController.text);
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save)),
//         ],
//       );
//     } else if (widget.ruleId == 22) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.rule,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.costPerMissedPunch),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: SizedBox(
//                   width: 200.h,
//                   child: TextField(
//                     controller: costPerMissedPunch,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(
//                       labelText: AppLocalizations.of(context)!.enterPerOccurrenceAmount,
//                       border: const OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 100.h,
//                 child: Text(AppLocalizations.of(context)!.missAcceptableTime),
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: SizedBox(
//                   width: 200.h,
//                   child: TextField(
//                     controller: missAcceptableTime,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                     decoration: InputDecoration(
//                       labelText: AppLocalizations.of(context)!.enterHowMManyTimeAcceptable,
//                       border: const OutlineInputBorder(),
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           SizedBox(height: 10.h),
//           Text.rich(
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.ifYouMissPunchCertain}'
//                   '\n• ${AppLocalizations.of(context)!.aFewTimesYouMayBe}'
//                   '\n',
//               children: <TextSpan>[
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.example,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const TextSpan(
//                   text: '',
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(p1: costPerMissedPunch.text, p2: missAcceptableTime.text);
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     } else if (widget.ruleId == 23) {
//       content = Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.rule,
//             style: dTexts.titleSmall,
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               Radio<bool>(
//                 value: true,
//                 groupValue: _overtime,
//                 onChanged: (bool? value) {
//                   setState(() {
//                     _overtime = value!;
//                   });
//                 },
//               ),
//               Text(AppLocalizations.of(context)!.yes),
//               Radio<bool>(
//                 value: false,
//                 groupValue: _overtime,
//                 onChanged: (bool? value) {
//                   setState(() {
//                     _overtime = value!;
//                   });
//                 },
//               ),
//               Text(AppLocalizations.of(context)!.no),
//             ],
//           ),
//           if (_overtime)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: TextFormField(
//                 controller: _overtimeRateController,
//                 decoration: InputDecoration(
//                   labelText: AppLocalizations.of(context)!.overtimeRate,
//                   border: const OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//               ),
//             ),
//           Text(AppLocalizations.of(context)!.details, style: dTexts.titleSmall),
//           const SizedBox(height: 10),
//           Text.rich(
//             TextSpan(
//               text: '\n• ${AppLocalizations.of(context)!.ifYouComeAndSelectYes} \n'
//                   '\n• ${AppLocalizations.of(context)!.andIfYouSelectNoThen} \n',
//             ),
//           ),
//           SizedBox(height: DSizes.spaceBtwItems),
//           PrimaryButton(
//               height: DSizes.buttonHeight,
//               onPressed: () {
//                 _saveRule(
//                   p1: _overtime.toString(),
//                   p2: _overtime ? _overtimeRateController.text : '',
//                 );
//               },
//               tittleText: Text(AppLocalizations.of(context)!.save))
//         ],
//       );
//     } else {
//       content = Text(
//         AppLocalizations.of(context)!.thisRuleHasNotYetBeenConfirmedSoItWillNotBeEnforced,
//         style: const TextStyle(fontSize: 24),
//       );
//     }
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: appBar2(AppLocalizations.of(context)!.rulesDetails, context),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height, // Adjust height as needed
//           child: Padding(
//             padding: REdgeInsets.all(16.0),
//             child: content,
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showWorkTimeDialog(BuildContext context, String workTimeType) {
//     TimeOfDay selectedStartTime;
//     TimeOfDay selectedEndTime;
//
//     switch (workTimeType) {
//       case 'AM':
//         selectedStartTime = selectedAMStartTime;
//         selectedEndTime = selectedAMEndTime;
//         break;
//       case 'PM':
//         selectedStartTime = selectedPMStartTime;
//         selectedEndTime = selectedPMEndTime;
//         break;
//       case 'Over':
//         selectedStartTime = selectedOverStartTime;
//         selectedEndTime = selectedOverEndTime;
//         break;
//       default:
//         selectedStartTime = const TimeOfDay(hour: 0, minute: 0); // Default value
//         selectedEndTime = const TimeOfDay(hour: 0, minute: 0); // Default value
//         break;
//     }
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             Future<void> _showTimePicker(String type) async {
//               final TimeOfDay? pickedTime = await showTimePicker(
//                 context: context,
//                 initialTime: type == 'Start' ? selectedStartTime : selectedEndTime,
//                 builder: (context, child) {
//                   return MediaQuery(
//                     data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
//                     child: child ?? Container(),
//                   );
//                 },
//               );
//               if (pickedTime != null) {
//                 setState(() {
//                   if (type == 'Start') {
//                     selectedStartTime = pickedTime;
//                   } else if (type == 'End') {
//                     selectedEndTime = pickedTime;
//                   }
//                 });
//               }
//             }
//
//             return AlertDialog(
//               title: Text(
//                 AppLocalizations.of(context)!.selectWorkTime,
//                 style: Theme.of(context).textTheme.titleSmall,
//               ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ListTile(
//                     title: Text(
//                       AppLocalizations.of(context)!.startTime,
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     ),
//                     trailing: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(4),
//                         border: Border.all(color: Colors.blue),
//                       ),
//                       child: Text(
//                         _formatTimeOfDay(selectedStartTime),
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     onTap: () {
//                       _showTimePicker('Start');
//                     },
//                   ),
//                   ListTile(
//                     title: Text(AppLocalizations.of(context)!.endTime, style: Theme.of(context).textTheme.bodyLarge),
//                     trailing: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(4),
//                         border: Border.all(color: Colors.blue),
//                       ),
//                       child: Text(
//                         _formatTimeOfDay(selectedEndTime),
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     onTap: () {
//                       _showTimePicker('End');
//                     },
//                   ),
//                 ],
//               ),
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Flexible(child: CancelButton(height: DSizes.buttonHeight)),
//                       SizedBox(width: DSizes.spaceBtwItems),
//                       Flexible(
//                         child: PrimaryButton(
//                             height: DSizes.buttonHeight,
//                             onPressed: () {
//                               setState(() {
//                                 switch (workTimeType) {
//                                   case 'AM':
//                                     selectedAMStartTime = selectedStartTime;
//                                     selectedAMEndTime = selectedEndTime;
//                                     break;
//                                   case 'PM':
//                                     selectedPMStartTime = selectedStartTime;
//                                     selectedPMEndTime = selectedEndTime;
//                                     break;
//                                   case 'Over':
//                                     selectedOverStartTime = selectedStartTime;
//                                     selectedOverEndTime = selectedEndTime;
//                                     break;
//                                 }
//                               });
//                               Navigator.of(context).pop();
//                             },
//                             tittleText: Text(AppLocalizations.of(context)!.oK)),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             );
//           },
//         );
//       },
//     ).then((_) {
//       setState(() {});
//     });
//   }
//
//   String _formatTimeOfDay(TimeOfDay timeOfDay) {
//     final hour = timeOfDay.hour.toString().padLeft(2, '0');
//     final minute = timeOfDay.minute.toString().padLeft(2, '0');
//     return '$hour:$minute';
//   }
//
//   Future<void> _saveSelectedDays() async {
//     String selectedDays =
//     daysChecked.asMap().entries.where((entry) => entry.value).map((entry) => weekdays[entry.key]).join(',');
//
//     await _saveRule(p1: selectedDays);
//   }
//
//   Future<void> _saveDocument() async {
//     if (selectDate != null && selectedImageFile != null && cutSalary != null) {
//       // Format the selectedDate as yyyy-MM-dd
//       String formattedDate = DateFormat('yyyy-MM-dd').format(selectDate!);
//
//       // Save the formatted date, image file path, and cutSalary
//       await databaseHelper.insertOrUpdatePunchDocument(
//         widget.empId,
//         formattedDate,
//         selectedImageFile!.path,
//         cutSalary == true ? "Yes" : "No",
//       );
//
//       // Show success message
//       DSnackBar.successSnackBar(title: AppLocalizations.of(context)!.dataSavedSuccessfully);
//       await _loadDocuments();
//
//       // Reset the state
//       selectDate = null;
//       selectedImageFile = null;
//       cutSalary = false;
//       setState(() {});
//     } else {
//       // Show error message if any required field is missing
//       DSnackBar.errorSnackBar(title: AppLocalizations.of(context)!.pleaseSelectADateAndImage);
//     }
//   }
//
//   Widget showMonthYearPicker(BuildContext context, DateTime tempDate, ValueChanged<DateTime> onDateChanged) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.4,
//       child: CupertinoDatePicker(
//         mode: CupertinoDatePickerMode.date,
//         initialDateTime: tempDate,
//         minimumYear: 2000,
//         maximumYear: 2100,
//         onDateTimeChanged: (DateTime newDateTime) {
//           onDateChanged(newDateTime);
//         },
//         dateOrder: DatePickerDateOrder.ymd,
//       ),
//     );
//   }
//
//   Future<void> _showMonthYearPickerDialog(BuildContext context, StateSetter setState) async {
//     // Initialize temporary date with the current date or existing selectDate
//     DateTime tempDate = selectDate ?? DateTime.now();
//
//     showModalBottomSheet(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10.0),
//           topRight: Radius.circular(10.0),
//         ),
//       ),
//       context: context,
//       builder: (BuildContext context) {
//         final appLocalizations = AppLocalizations.of(context)!;
//
//         return SizedBox(
//           height: MediaQuery.of(context).size.height * 0.4,
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//                 decoration: const BoxDecoration(
//                   border: Border(bottom: BorderSide(color: Colors.grey, width: 2)),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(Icons.close, size: 20),
//                     ),
//                     Text(
//                       appLocalizations.selectMonth,
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           selectDate = tempDate;
//                         });
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(Icons.done, size: 20),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: showMonthYearPicker(
//                   context,
//                   tempDate,
//                       (DateTime newDateTime) {
//                     // Update the temporary date
//                     setState(() {
//                       tempDate = newDateTime;
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
