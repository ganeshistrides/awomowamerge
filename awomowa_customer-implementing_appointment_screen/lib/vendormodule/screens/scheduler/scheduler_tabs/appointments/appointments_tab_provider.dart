
import 'package:awomowa/utils/app_utils.dart';
import 'package:awomowa/vendormodule/https/model/slots/schedule_list_response.dart';
import 'package:awomowa/vendormodule/https/repository/scheduler_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentsTabProvider extends ChangeNotifier {
  bool isLoading = false;
  final List<BookingHistory> bookingHistoryForUpcoming = [];
  final reasonContoller = TextEditingController();
  int currentIndex = 0;
  final List<BookingHistory> bookingHistoryForHistory = [];

  //Initial

  Future<void> init() async {
    reasonContoller.clear();
    bookingHistoryForHistory.clear();
    bookingHistoryForUpcoming.clear();
    isLoading = true;
    final baseResponse = await Future.wait([
      SchedulerRepository.getVendorScheduleHistory(),
      SchedulerRepository.getVendorUpcomingSchedules()
    ]);

    for (final response in baseResponse) {
      if (response is ScheduleListResponse) {
        if (response.status == 'success' && response.responseFor == "history") {
          bookingHistoryForHistory.addAll(response.bookingHistory);
          notifyListeners();
        } else if (response.status == 'success' &&
            response.responseFor == "upcoming") {
          bookingHistoryForUpcoming.addAll(response.bookingHistory);
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

  //Cancel Schedule

  Future<void> approveAppointment(String bookedID) async {
    isLoading = true;
    final response = await SchedulerRepository.approveAppointment(
      bookedId: bookedID,
    );
    if (response.status == 'success') {
      AppUtils.showToast(response.message);
      init();
      notifyListeners();
    } else {
      isLoading = false;
      AppUtils.showToast(response.message, color: Colors.red);
      notifyListeners();
    }
  }

  //Cancel Schedule

  Future<void> cancelAppointment(String bookedID) async {
    if (reasonContoller.text.isEmpty) {
      AppUtils.showToast("Reason is Required", color: Colors.red);
      return;
    }
    isLoading = true;
    final response = await SchedulerRepository.cancelAppointment(
        bookedId: bookedID, reason: reasonContoller.text);
    if (response.status == 'success') {
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
