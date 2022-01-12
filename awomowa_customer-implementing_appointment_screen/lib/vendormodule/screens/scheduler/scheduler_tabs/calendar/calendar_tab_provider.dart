import 'package:awomowa/utils/app_utils.dart';
import 'package:awomowa/vendormodule/https/model/calendar/calendar_response.dart';
import 'package:awomowa/vendormodule/https/model/slots/slots_response.dart';
import 'package:awomowa/vendormodule/https/repository/scheduler_repository.dart';
import 'package:awomowa/vendormodule/import_barrel.dart';
import 'package:awomowa/vendormodule/time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CalendarTabProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingForCalendar = false;
  final List<Slots> slots = [];
  final List<DateTime> availableDates = [];
  List<SlotsGroups> slotGroups = [];
  final scrollContoller = ItemScrollController();
  CalenderResponse calenderResponse;
  int index;

  DateTime selectedDateTime = DateTime.now();

  //Initial
  Future<void> init() async {
    selectedDateTime = DateTime.now();
    isLoadingForCalendar = false;
    availableDates.clear();
    slots.clear();
    calenderResponse = null;
    slotGroups.clear();
    isLoading = true;
    final baseResponse = await Future.wait([
      SchedulerRepository.getAllSlots(),
      SchedulerRepository.getScheduleBasedOnDate(selectedDateTime),
      SchedulerRepository.getAvailabelDates()
    ]);

    for (final response in baseResponse) {
      if (response is CalenderResponse) {
        if (response.status == 'success') {
          calenderResponse = response;
          slots.addAll(response.slotTimings);
        } else {
          isLoading = false;
          AppUtils.showToast(response.message, color: Colors.red);

          notifyListeners();
        }
      }
      if (response is SlotsResponse) {
        if (response.status == 'success') {
          slotGroups.addAll(response.availableGroups);
          notifyListeners();
        } else {
          isLoading = false;
          AppUtils.showToast(response.message, color: Colors.red);
          notifyListeners();
        }
      }
      if (response is CalenderAvailableDatesResponse) {
        if (response.status == 'success') {
          for (final item in response.dateList) {
            availableDates.add(DateFormat('MM\/dd/yyyy').parse(item));
          }

          index = availableDates.indexWhere((element) =>
              TimeUtils.checkDate(selectedDateTime, actualDate: element));
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          AppUtils.showToast(response.message, color: Colors.red);
          notifyListeners();
        }
      }
    }
  }

  //Add Schedule
  Future<void> createSchedule(BuildContext context, String id) async {
    slots.clear();
    isLoadingForCalendar = true;
    notifyListeners();

    final response =
        await SchedulerRepository.addSchedule(id, selectedDateTime);
    if (response.status == 'success') {
      Navigator.pop(context);
      calenderResponse = null;

      AppUtils.showToast(response.message);
      final responses =
          await SchedulerRepository.getScheduleBasedOnDate(selectedDateTime);
      if (responses.status == 'success') {
        calenderResponse = responses;
        slots.addAll(responses.slotTimings);
        isLoadingForCalendar = false;
        notifyListeners();
      } else {
        isLoadingForCalendar = false;
        AppUtils.showToast(response.message, color: Colors.red);

        notifyListeners();
      }
      notifyListeners();
    } else if (response.status == 'error') {
      isLoadingForCalendar = false;
      Navigator.pop(context);

      AppUtils.showToast(response.message, color: Colors.red);

      notifyListeners();
    }
  }

  //Change Schedule
  Future<void> changeSchedule(BuildContext context, String id) async {
    isLoadingForCalendar = true;
    notifyListeners();

    final response =
        await SchedulerRepository.changeSchedule(id, selectedDateTime);
    if (response.status == 'success') {
      slots.clear();
      calenderResponse = null;
      Navigator.pop(context);
      AppUtils.showToast(response.message);
      final responses =
          await SchedulerRepository.getScheduleBasedOnDate(selectedDateTime);
      if (responses.status == 'success') {
        calenderResponse = responses;
        slots.addAll(responses.slotTimings);
        isLoadingForCalendar = false;
        notifyListeners();
      } else {
        isLoadingForCalendar = false;
        AppUtils.showToast(response.message, color: Colors.red);

        notifyListeners();
      }
      notifyListeners();
    } else if (response.status == 'error') {
      isLoading = false;
      Navigator.pop(context);
      isLoadingForCalendar = false;

      AppUtils.showToast(response.message, color: Colors.red);

      notifyListeners();
    }
  }

  //Remove Perticular Slot in the Schedule

  Future<void> removeSlot(String slotId) async {
    isLoadingForCalendar = true;
    notifyListeners();

    final response = await SchedulerRepository.removeSlotFromSchedule(slotId);
    if (response.status == 'success') {
      AppUtils.showToast(response.message);
      slots.clear();
      calenderResponse = null;
      final responses =
          await SchedulerRepository.getScheduleBasedOnDate(selectedDateTime);
      if (responses.status == 'success') {
        calenderResponse = responses;
        slots.addAll(responses.slotTimings);
        isLoadingForCalendar = false;
        notifyListeners();
      } else {
        isLoadingForCalendar = false;
        AppUtils.showToast(response.message, color: Colors.red);
        notifyListeners();
      }
      notifyListeners();
    } else {
      isLoadingForCalendar = false;

      AppUtils.showToast(response.message, color: Colors.red);

      notifyListeners();
    }
  }

  //Remove Schedule

  Future<void> removeSchedule() async {
    isLoadingForCalendar = true;
    notifyListeners();

    final response =
        await SchedulerRepository.removeSchedule(calenderResponse.schedulerId);
    if (response.status == 'status') {
      AppUtils.showToast(response.message);
      slots.clear();
      calenderResponse = null;
      final responses =
          await SchedulerRepository.getScheduleBasedOnDate(selectedDateTime);
      if (responses.status == 'success') {
        calenderResponse = responses;
        slots.addAll(responses.slotTimings);
        isLoadingForCalendar = false;
        notifyListeners();
      } else if (responses.status == 'error') {
        isLoadingForCalendar = false;
        notifyListeners();
        AppUtils.showToast(response.message, color: Colors.red);
      }
    } else {
      isLoadingForCalendar = false;
      AppUtils.showToast(response.message, color: Colors.red);

      notifyListeners();
    }
  }

//Date Pick
  Future<void> datePick(DateTime dateTime) async {
    isLoadingForCalendar = true;
    notifyListeners();

    selectedDateTime = dateTime;
    slots.clear();
    calenderResponse = null;
    final response = await SchedulerRepository.getScheduleBasedOnDate(dateTime);
    if (response.status == 'success') {
      calenderResponse = response;
      slots.addAll(response.slotTimings);
      notifyListeners();
      isLoadingForCalendar = false;
    } else {
      isLoadingForCalendar = false;
      AppUtils.showToast(response.message, color: Colors.red);

      notifyListeners();
    }
  }
}
