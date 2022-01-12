import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/calendar/calendar_tab_provider.dart';
import 'package:awomowa/vendormodule/time_utils.dart';
import 'package:awomowa/vendormodule/widgets/loader_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:awomowa/vendormodule/widgets/common/custom_alert_dialogue.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({Key key}) : super(key: key);
  static const routeName = 'calendarTab';

  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  @override
  void initState() {
    final provider = context.read<CalendarTabProvider>();
    provider.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarTabProvider>(builder: (context, provider, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Calendar"),
          ),
          body: provider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _BuildLayout());
    });
  }
}

class _BuildLayout extends StatelessWidget {
  const _BuildLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [Expanded(child: _BuildCalender())]),
        Selector<CalendarTabProvider, bool>(
            builder: (context, value, child) {
              return value
                  ? Expanded(child: Center(child: CircularProgressIndicator()))
                  : _BuildCaledarDetails();
            },
            selector: (context, provider) => provider.isLoadingForCalendar)
      ],
    );
  }
}

//Calender
class _BuildCalender extends StatelessWidget {
  _BuildCalender({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CalendarTabProvider>();

    return Container(
        height: 100,
        child: ScrollablePositionedList.builder(
            initialScrollIndex: provider.index,
            itemScrollController: provider.scrollContoller,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  provider.datePick(provider.availableDates[index]);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: TimeUtils.checkDate(provider.selectedDateTime,
                              actualDate: provider.availableDates[index])
                          ? const Color(0xffFFC324)
                          : Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            TimeUtils.convertddLLLYYYYDate(
                                    provider.availableDates[index])
                                .split(" ")[1],
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            provider.availableDates[index].day.toString(),
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            provider.availableDates[index].year.toString(),
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: provider.availableDates.length));
  }
}

class _BuildCaledarDetails extends StatelessWidget {
  const _BuildCaledarDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CalendarTabProvider>();

    return Selector<CalendarTabProvider, bool>(
        builder: (contxt, value, child) {
          return value
              ? Expanded(
                  child: Center(
                    child: Container(
                      height: 150,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Text(
                            "Slots For this day or this day will be unavailable for users",
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LoaderButton(
                            onPressed: () {
                              Alert(
                                  context: context,
                                  style: AlertStyle(isButtonVisible: false),
                                  title: "Slot List",
                                  content: SingleChildScrollView(
                                    child: SizedBox(
                                      height: 300,
                                      width: 300,
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        child: ListView.separated(
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () {
                                                  provider.createSchedule(
                                                      context,
                                                      provider.slotGroups[index]
                                                          .groupId);
                                                },
                                                title: Text(provider
                                                    .slotGroups[index]
                                                    .groupName),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return Divider();
                                            },
                                            itemCount:
                                                provider.slotGroups.length),
                                      ),
                                    ),
                                  )).show();
                            },
                            btnTxt: 'Select Slot',
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(top: 20, right: 10, left: 10),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        children: [
                          Selector<CalendarTabProvider, DateTime>(
                              builder: (context, value, child) {
                                return Row(
                                  children: [
                                    Text(
                                      "${TimeUtils.convertLLLDDYYYYDate(provider.selectedDateTime)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                );
                              },
                              selector: (context, provider) =>
                                  provider.selectedDateTime),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, right: 15, left: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Make this Day UnAvailable",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          CustomAlertDialog.showdialog(
                                              context: context,
                                              title: "Confirmation Dialog",
                                              type: AlertType.warning,
                                              description:
                                                  "Are you sure you want to Remove this Schedule",
                                              positiveText: "Yes",
                                              negativeText: "No",
                                              positiveFunction: () {
                                                provider.removeSchedule();

                                                Navigator.pop(context);
                                              },
                                              negativeFunction: () {
                                                Navigator.pop(context);
                                              });
                                        },
                                        child: Icon(
                                          Icons.cancel,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Alert(
                                        context: context,
                                        title: "Slot List",
                                        style:
                                            AlertStyle(isButtonVisible: false),
                                        content: SingleChildScrollView(
                                          child: SizedBox(
                                            height: 300,
                                            width: 300,
                                            child: Container(
                                              margin: const EdgeInsets.all(10),
                                              child: ListView.separated(
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      onTap: () {
                                                        provider.changeSchedule(
                                                            context,
                                                            provider
                                                                .slotGroups[
                                                                    index]
                                                                .groupId);
                                                      },
                                                      title: Text(provider
                                                          .slotGroups[index]
                                                          .groupName),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return Divider();
                                                  },
                                                  itemCount: provider
                                                      .slotGroups.length),
                                            ),
                                          ),
                                        )).show();
                                  },
                                  child: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        right: 15,
                                        left: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.yellow[700],
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Change Slot For This Day",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.schedule,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    color:
                                        provider.slots[index].bookingDetails ==
                                                null
                                            ? Colors.green
                                            : Colors.red,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Text(
                                        getTime(
                                            TimeUtils.convertTimeofDay(provider
                                                .slots[index].startTime),
                                            TimeUtils.convertTimeofDay(
                                                provider.slots[index].endTime)),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                                if (provider.slots[index].bookingDetails ==
                                    null)
                                  ListTile(
                                    title: Text("No Bookings"),
                                    trailing: GestureDetector(
                                        onTap: () {
                                          CustomAlertDialog.showdialog(
                                              context: context,
                                              title: "Confirmation Dialog",
                                              type: AlertType.warning,
                                              description:
                                                  "Are you sure you want to delete this Slot",
                                              positiveText: "Yes",
                                              negativeText: "No",
                                              positiveFunction: () {
                                                provider.removeSlot(provider
                                                    .slots[index].slotId);
                                                Navigator.pop(context);
                                              },
                                              negativeFunction: () {
                                                Navigator.pop(context);
                                              });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.grey,
                                        )),
                                  )
                                else
                                  ListTile(
                                    title: Text(provider.slots[index]
                                        .bookingDetails.customerName),
                                    subtitle: Text(provider.slots[index]
                                        .bookingDetails.serviceName),
                                    trailing: GestureDetector(
                                        onTap: () {
                                          CustomAlertDialog.showdialog(
                                              context: context,
                                              title: "Confirmation Dialog",
                                              type: AlertType.warning,
                                              description:
                                                  "Are you sure you want to delete this Slot",
                                              positiveText: "Yes",
                                              negativeText: "No",
                                              positiveFunction: () {
                                                provider.removeSlot(provider
                                                    .slots[index].slotId);
                                                Navigator.pop(context);
                                              },
                                              negativeFunction: () {
                                                Navigator.pop(context);
                                              });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.grey,
                                        )),
                                  ),
                              ],
                            ),
                          );
                        },
                        itemCount: provider.slots.length,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                );
        },
        selector: (context, provider) => provider.slots.isEmpty);
  }

  String getTime(TimeOfDay startTime, TimeOfDay endTime) {
    return "${TimeUtils.convertAmPM(TimeUtils.convertHIS(startTime))} - ${TimeUtils.convertAmPM(TimeUtils.convertHIS(endTime))} ";
  }
}
