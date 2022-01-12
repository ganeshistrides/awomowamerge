

import 'package:awomowa/vendormodule/https/model/calendar/calendar_response.dart';
import 'package:awomowa/vendormodule/https/model/generic_response.dart';
import 'package:awomowa/vendormodule/https/model/service/service_response.dart';
import 'package:awomowa/vendormodule/https/model/slots/schedule_list_response.dart';
import 'package:awomowa/vendormodule/https/model/slots/slots_response.dart';
import 'package:awomowa/vendormodule/import_barrel.dart';
import 'package:awomowa/vendormodule/time_utils.dart';
import 'package:awomowa/vendormodule/widgets/common/custom_time_range_picker.dart';

class SchedulerRepository {
  const SchedulerRepository._();

//Service

  //Get All Service
  static Future<ServiceResponse> getAllServices() async {
    final response = await loadApi(
        apiUrl: GETALLSERVICE, params: {"apiMethod": "serviceList"});
    final ServiceResponse serviceResponse =
        ServiceResponse.fromJson(response as Map<String, dynamic>);
    return serviceResponse;
  }

  //Delete Service
  static Future<GenericResponse> deleteService(String serviceId) async {
    final response = await loadApi(
        apiUrl: GETALLSERVICE,
        params: {"apiMethod": "removeService", "serviceId": serviceId});
    final GenericResponse genericResponse =
        GenericResponse.fromJson(response as Map<String, dynamic>);
    return genericResponse;
  }

  //Add Service
  static Future<GenericResponse> addService(String serviceName) async {
    final response = await loadApi(
        apiUrl: GETALLSERVICE,
        params: {"apiMethod": "saveService", "serviceName": serviceName});
    final GenericResponse genericResponse =
        GenericResponse.fromJson(response as Map<String, dynamic>);
    return genericResponse;
  }

//Slots

  //Get All Slots
  static Future<SlotsResponse> getAllSlots() async {
    final response = await loadApi(
        apiUrl: SLOTS, params: {"apiMethod": "availableGroupListwithSlot"});
    final SlotsResponse slotsResponse =
        SlotsResponse.fromJson(response as Map<String, dynamic>);
    return slotsResponse;
  }

  //Delete Slots
  static Future<GenericResponse> deleteSlots(String groupId) async {
    final response = await loadApi(
        apiUrl: SLOTS,
        params: {"apiMethod": "removeGroup", "groupId": groupId});
    final GenericResponse genericResponse =
        GenericResponse.fromJson(response as Map<String, dynamic>);
    return genericResponse;
  }

  //Add Slots
  static Future<GenericResponse> addSlots(
      String slotName, List<TimeRangeValue> slots) async {
    final List<Map<String, String>> data = [];
    for (final item in slots) {
      final result = {
        "from": TimeUtils.convertAmPM(TimeUtils.convertHIS(item.startTime)),
        "to": TimeUtils.convertAmPM(TimeUtils.convertHIS(item.endTime))
      };
      data.add(result);
    }
    final response = await loadApi(
        apiUrl: CREATE_SLOT,
        params: {"apiMethod": "saveSlot", "slotName": slotName, "slots": data});
    final GenericResponse genericResponse =
        GenericResponse.fromJson(response as Map<String, dynamic>);
    return genericResponse;
  }

//Calendar

  //Available Dates

  static Future<CalenderAvailableDatesResponse> getAvailabelDates() async {
    final response = await loadApi(apiUrl: AVAILABLE_DATES, params: {
      "apiMethod": "dateList",
    });
    final CalenderAvailableDatesResponse availableDatesResponse =
        CalenderAvailableDatesResponse.fromJson(
            response as Map<String, dynamic>);
    return availableDatesResponse;
  }

  //Add Schedule
  static Future<GenericResponse> addSchedule(
      String selectedGroupID, DateTime selectedDate) async {
    final response = await loadApi(apiUrl: CREATE_SCHEDULR, params: {
      "apiMethod": "createNewSchedule",
      "selectedGroupId": selectedGroupID,
      "selectedDate": TimeUtils.converttoAPIdateFormat(selectedDate)
    });
    final GenericResponse genericResponse =
        GenericResponse.fromJson(response as Map<String, dynamic>);
    return genericResponse;
  }

  //Change Schedule
  static Future<GenericResponse> changeSchedule(
      String selectedGroupID, DateTime selectedDate) async {
    final response = await loadApi(apiUrl: CHANGE_SCHEDULER, params: {
      "apiMethod": "changeSchedule",
      "selectedGroupId": selectedGroupID,
      "selectedDate": TimeUtils.converttoAPIdateFormat(selectedDate)
    });
    final GenericResponse genericResponse =
        GenericResponse.fromJson(response as Map<String, dynamic>);
    return genericResponse;
  }

  //Get Schedule Base on Date

  static Future<CalenderResponse> getScheduleBasedOnDate(DateTime date) async {
    final response = await loadApi(apiUrl: SCHEDULE_LIST, params: {
      "apiMethod": "scheduleList",
      "dateFilter": TimeUtils.converttoAPIdateFormat(date)
    });
    final CalenderResponse calendarResponse =
        CalenderResponse.fromJson(response as Map<String, dynamic>);
    return calendarResponse;
  }

  //Remove Slot From Schedule
  static Future<GenericResponse> removeSlotFromSchedule(String slotId) async {
    final response = await loadApi(
        apiUrl: REMOVE_SLOT_FROM_SCHEDULE,
        params: {"apiMethod": "removeSlot", "slotId": slotId});
    final GenericResponse genericResponse =
        GenericResponse.fromJson(response as Map<String, dynamic>);
    return genericResponse;
  }

  //Remove  Schedule
  static Future<GenericResponse> removeSchedule(String scheduleId) async {
    final response = await loadApi(
        apiUrl: REMOVE_SCHEDULR_FOR_THE_DAY,
        params: {"apiMethod": "removeSchedule", "scheduleId": scheduleId});
    final GenericResponse genericResponse =
        GenericResponse.fromJson(response as Map<String, dynamic>);
    return genericResponse;
  }

  //History Appointments

  static Future<ScheduleListResponse> getVendorScheduleHistory() async {
    final response = await loadApi(apiUrl: VENDOR_SCHEDULE_LIST, params: {
      "apiMethod": "vendorScheduleHistory",
    });
    final ScheduleListResponse scheduleListResponse =
        ScheduleListResponse.fromJson(response as Map<String, dynamic>);
    return scheduleListResponse;
  }

  //Upcoming Appointments
  static Future<ScheduleListResponse> getVendorUpcomingSchedules() async {
    final response = await loadApi(apiUrl: VENDOR_SCHEDULE_LIST, params: {
      "apiMethod": "vendorUpcomingSchedules",
    });
    final ScheduleListResponse scheduleListResponse =
        ScheduleListResponse.fromJson(response as Map<String, dynamic>);
    return scheduleListResponse;
  }

  //Approve Appointments
  static Future<ScheduleListResponse> approveAppointment(
      {String bookedId}) async {
    final response =
        await loadApi(apiUrl: VENDOR_BOOKING_STATUS_UPDATE, params: {
      "apiMethod": "vendorBookingStatusUpdate",
      "bookedId": bookedId,
      "vendorStatus": "approved",
    });
    final ScheduleListResponse scheduleListResponse =
        ScheduleListResponse.fromJson(response as Map<String, dynamic>);
    return scheduleListResponse;
  }

  //Cancel Appointments
  static Future<ScheduleListResponse> cancelAppointment(
      {String reason, String bookedId}) async {
    final response =
        await loadApi(apiUrl: VENDOR_BOOKING_STATUS_UPDATE, params: {
      "apiMethod": "vendorBookingStatusUpdate",
      "bookedId": bookedId,
      "vendorStatus": "rejected",
      "rejectionReason": reason
    });
    final ScheduleListResponse scheduleListResponse =
        ScheduleListResponse.fromJson(response as Map<String, dynamic>);
    return scheduleListResponse;
  }
}
