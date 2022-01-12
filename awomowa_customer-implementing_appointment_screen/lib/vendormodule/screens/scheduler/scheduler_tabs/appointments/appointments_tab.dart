
import 'package:awomowa/utils/time_utils.dart';
import 'package:awomowa/vendormodule/https/model/slots/schedule_list_response.dart';

//import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/appointments/appointments_tab_provider.dart';
//import 'package:awomowa/vendormodule/import_barrel.dart';
import 'package:awomowa/vendormodule/widgets/common/custom_alert_dialogue.dart';
import 'package:awomowa/vendormodule/widgets/form_field.dart';
import 'package:awomowa/widgets/TabIndicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/appointments/appointments_tab_provider.dart';

class AppointmentsTab extends StatefulWidget {
  const AppointmentsTab({Key key}) : super(key: key);
  static const routeName = 'appointmentsTab';

  @override
  _AppointmentsTabState createState() => _AppointmentsTabState();
}

class _AppointmentsTabState extends State<AppointmentsTab> {
  @override
  void initState() {
    final provider = context.read<AppointmentsTabProvider>();

    provider.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentsTabProvider>(
        builder: (context, provider, child) {
      return DefaultTabController(
        initialIndex: provider.currentIndex,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicator: CircleTabIndicator(color: Colors.black, radius: 3),
              unselectedLabelColor: Colors.white,
              tabs: [
                const Tab(
                  icon: Text("Upcoming"),
                ),
                const Tab(icon: Text("History")),
              ],
            ),
            title: const Text('Appointments'),
          ),
          body: Selector<AppointmentsTabProvider, bool>(
            builder: (context, value, child) {
              return value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : const TabBarView(
                      children: [_BuildUpComingScreen(), _BuildHistoryScreen()],
                    );
            },
            selector: (context, provider) => provider.isLoading,
          ),
        ),
      );
    });
  }
}

//UpComing Tab

class _BuildUpComingScreen extends StatelessWidget {
  const _BuildUpComingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppointmentsTabProvider>();
    if (provider.bookingHistoryForUpcoming.isEmpty) {
      return Center(
        child: Text("No Appointment Available"),
      );
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return _BuildAppointmentCard(
          history: provider.bookingHistoryForUpcoming[index],
        );
      },
      itemCount: provider.bookingHistoryForUpcoming.length,
    );
  }
}

//History Tab

class _BuildHistoryScreen extends StatelessWidget {
  const _BuildHistoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppointmentsTabProvider>();
    if (provider.bookingHistoryForHistory.isEmpty) {
      return Center(
        child: Text("No Appointment History Available"),
      );
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return _BuildAppointmentCard(
          isHistoryTab: true,
          history: provider.bookingHistoryForHistory[index],
        );
      },
      itemCount: provider.bookingHistoryForHistory.length,
    );
  }
}

//Appointment Card
class _BuildAppointmentCard extends StatelessWidget {
  final bool isHistoryTab;
  final BookingHistory history;
  const _BuildAppointmentCard({this.isHistoryTab = false, this.history});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppointmentsTabProvider>();

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[400],
          ),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.orange,
                backgroundImage: NetworkImage(history.userProfileImage),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      history.userName,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: !isHistoryTab
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                color: history.bookingStatus == 'pending'
                                    ? Colors.orange[50]
                                    : Colors.green[100],
                                child: Text(
                                  toBeginningOfSentenceCase(
                                      history.bookingStatus),
                                  style: TextStyle(
                                      color: history.bookingStatus == 'pending'
                                          ? Colors.orange
                                          : Colors.green,
                                      fontSize: 12.0),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                if (history.bookingStatus == 'cancelled') {
                                  Alert(
                                      context: context,
                                      title: "Cancel Reason",
                                      style: AlertStyle(isButtonVisible: false),
                                      content: SizedBox(
                                        height: 300,
                                        width: 300,
                                        child: Container(
                                            margin: const EdgeInsets.all(10),
                                            child: ListTile(
                                              title: Text(
                                                  "Reason : ${history.cancelReason}"),
                                              subtitle: Row(
                                                children: [
                                                  Text(
                                                      "Canceled By : ${history.cancelledBy}"),
                                                ],
                                              ),
                                            )),
                                      )).show();
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  color: history.bookingStatus == 'cancelled'
                                      ? Colors.red[50]
                                      : Colors.green[100],
                                  child: Text(
                                    toBeginningOfSentenceCase(
                                        history.bookingStatus),
                                    style: TextStyle(
                                        color:
                                            history.bookingStatus == 'cancelled'
                                                ? Colors.red
                                                : Colors.green,
                                        fontSize: 12.0),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                        "${getTime(TimeUtils.convertTimeofDay(history.startTime), TimeUtils.convertTimeofDay(history.endTime))} | ${TimeUtils.convertddLLLYYYYDate(DateFormat('MM\/dd/yyyy').parse(history.bookedDate))}")
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [Text(history.serviceName)],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (!isHistoryTab && !(history.bookingStatus == 'confirmed'))
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            CustomAlertDialog.showdialog(
                                context: context,
                                title: "Confirmation Dialog",
                                type: AlertType.warning,
                                description:
                                    "Are you sure you want to Approve this Appointment",
                                positiveText: "Yes",
                                negativeText: "No",
                                positiveFunction: () {
                                  provider.approveAppointment(history.bookedId);
                                  Navigator.pop(context);
                                },
                                negativeFunction: () {
                                  Navigator.pop(context);
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, right: 10, left: 10),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check, color: Colors.white),
                                  Text(
                                    "Confirm",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            CustomAlertDialog.showdialog(
                                context: context,
                                title: "Confirmation Dialog",
                                type: AlertType.warning,
                                description:
                                    "Are you sure you want to Cancel this Appointment",
                                positiveText: "Yes",
                                content: Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: GlobalFormField(
                                    hint: 'Reason',
                                    prefixIcon: Icons.help,
                                    controller: provider.reasonContoller,
                                    validator: (value) {
                                      if (value.length < 1) {
                                        return 'Please Enter Valid Reason';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                                negativeText: "No",
                                positiveFunction: () {
                                  provider.cancelAppointment(history.bookedId);
                                  Navigator.pop(context);
                                },
                                negativeFunction: () {
                                  Navigator.pop(context);
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, right: 10, left: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cancel, color: Colors.red),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                else if (!isHistoryTab && history.bookingStatus == 'confirmed')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          CustomAlertDialog.showdialog(
                              context: context,
                              title: "Confirmation Dialog",
                              type: AlertType.warning,
                              description:
                                  "Are you sure you want to Cancel this Appointment",
                              positiveText: "Yes",
                              content: Container(
                                margin: const EdgeInsets.only(
                                  top: 10,
                                ),
                                child: GlobalFormField(
                                  hint: 'Reason',
                                  prefixIcon: Icons.help,
                                  controller: provider.reasonContoller,
                                  validator: (value) {
                                    if (value.length < 1) {
                                      return 'Please Enter Valid Reason';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              negativeText: "No",
                              positiveFunction: () {
                                provider.cancelAppointment(history.bookedId);
                                Navigator.pop(context);
                              },
                              negativeFunction: () {
                                Navigator.pop(context);
                              });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 10, left: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cancel, color: Colors.red),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Cancel",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getTime(TimeOfDay startTime, TimeOfDay endTime) {
    return "${TimeUtils.convertAmPM(TimeUtils.convertHIS(startTime))} - ${TimeUtils.convertAmPM(TimeUtils.convertHIS(endTime))} ";
  }
}
