import 'package:awomowa/responsemodels/appointment/slots/slots_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_response.g.dart';

@JsonSerializable(createToJson: false)
class CalenderResponse {
  final String status;
  final String message;
  final String isHavingSlot;
  final String schedulerId;

  final String dayInWeek;
  final String selectedDate;
  final String createdAt;
  final String updatedAt;
  final List<Slots> slotTimings;
  final String currenttime;
  
  CalenderResponse(
      this.createdAt,
      this.dayInWeek,
      this.isHavingSlot,
      this.message,
      this.schedulerId,
      this.selectedDate,
      this.slotTimings,
      this.status,
      this.updatedAt,
      this.currenttime);

  factory CalenderResponse.fromJson(Map<String, dynamic> map) =>
      _$CalenderResponseFromJson(map);
}

@JsonSerializable(createToJson: false)
class CalenderAvailableDatesResponse {
  final String status;
  final String message;
  final List<String> dateList;
  final String currenttime;

  CalenderAvailableDatesResponse(this.dateList, this.message, this.status,this.currenttime);
  factory CalenderAvailableDatesResponse.fromJson(Map<String, dynamic> map) =>
      _$CalenderAvailableDatesResponseFromJson(map);
}
