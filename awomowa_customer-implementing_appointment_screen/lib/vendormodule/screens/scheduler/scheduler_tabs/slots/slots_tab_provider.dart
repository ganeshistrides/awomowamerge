import 'package:awomowa/utils/app_utils.dart';
import 'package:awomowa/vendormodule/https/model/slots/slots_response.dart';
import 'package:awomowa/vendormodule/https/repository/scheduler_repository.dart';
import 'package:awomowa/vendormodule/widgets/common/custom_time_range_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlotsTabProvider extends ChangeNotifier {
  bool isLoading = false;
  TimeRangeValue timeRangeValue;
  List<TimeRangeValue> slots = [];
  TimeOfDay startTime;
  TimeOfDay endTime ;
  List<SlotsGroups> slotGroups = [];
  final addSlotNameContoller = TextEditingController();

//Initial
  Future<void> init() async {
    slots.clear();
    slotGroups.clear();
    addSlotNameContoller.clear();
    isLoading = true;
    final response = await SchedulerRepository.getAllSlots();
    if (response.status == 'success') {
      slotGroups.addAll(response.availableGroups);
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      AppUtils.showToast(response.message, color: Colors.red);

      notifyListeners();
    }
  }

  //Pick From And To Time
  Future<void> pickStartTimeAndEndTime(TimeRangeValue data) async {
    if (data.startTime == null || data.endTime == null) {
      AppUtils.showToast("Select Both Start Time And End Time",
          color: Colors.red);
      return;
    } else {
      timeRangeValue = data;
      notifyListeners();
    }
  }

  //Add Slot To List
  void addSlots() {
    if (timeRangeValue != null) {
      slots.add(timeRangeValue);
      timeRangeValue = null;
      notifyListeners();
    } else {
      AppUtils.showToast(
        "Select Time First",
        color: Colors.red,
      );
      notifyListeners();
    }
  }

  //Add Slots Api Call

  Future<void> addSlotGroup(BuildContext context) async {
    if (addSlotNameContoller.text.isEmpty) {
      AppUtils.showToast("Slot Name is Required", color: Colors.red);
      return;
    }
    if (slots.isEmpty) {
      AppUtils.showToast("Slot are Required", color: Colors.red);
      return;
    }
    final response =
        await SchedulerRepository.addSlots(addSlotNameContoller.text, slots);
    if (response.status == 'success') {
      Navigator.pop(context);
      AppUtils.showToast(response.message);
      init();
      notifyListeners();
    } else {
      isLoading = false;
      AppUtils.showToast(response.message, color: Colors.red);

      notifyListeners();
    }
  }

  //Remove Slots
  void clearSlots() {
    slots.clear();
    notifyListeners();
  }

  //Delete SlotGroups
  Future<void> deleteSlotGroups(String id) async {
    final response = await SchedulerRepository.deleteSlots(id);
    if (response.status == 'status') {
      AppUtils.showToast(response.message);
      init();
      notifyListeners();
    } else {
      isLoading = false;
      AppUtils.showToast(response.message, color: Colors.red);

      notifyListeners();
    }
  }
}
