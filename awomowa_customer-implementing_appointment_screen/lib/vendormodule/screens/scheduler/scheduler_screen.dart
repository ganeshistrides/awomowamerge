
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_provider.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/calendar/calendar_tab.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/service/service_tab.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/slots/slots_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../import_barrel.dart';

class SchedulerScreen extends StatefulWidget {
  static const routeName = 'schedulerScreen';

  const SchedulerScreen({Key key}) : super(key: key);

  @override
  _SchedulerScreenState createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends State<SchedulerScreen> {
  SharedPrefManager sharedPrefManager = SharedPrefManager();
  bool allowToRenew = false;

  @override
  void initState() {
    checkRenewalStatus();
    super.initState();
  }

  checkRenewalStatus() async {
    allowToRenew = await sharedPrefManager.isAllowToRenew();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SchedulerProvider>(builder: (context, provider, child) {
      return Scaffold(
        body: provider.isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    color: AppTheme.themeColor,
                    child: Stack(
                      children: [
                        LoginScreenBg(),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).padding.top -
                                          12),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Card(
                                        color: Colors.black,
                                        shape: CircleBorder(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.chevron_left,
                                            color: AppTheme.themeColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Scheduler',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 24.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 20,
                          children: [
                            _SchedulerItem(
                              bgColor: Colors.red,
                              icon: Icons.scatter_plot_sharp,
                              title: "Slots",
                              onTap: () {
                                Navigator.pushNamed(
                                    context, SlotsTab.routeName);
                              },
                            ),
                            _SchedulerItem(
                              bgColor: Colors.green,
                              icon: Icons.calendar_today,
                              title: "Scheduler",
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CalendarTab.routeName);
                              },
                            ),
                            _SchedulerItem(
                              bgColor: Colors.blue,
                              icon: Icons.schedule,
                              title: "Appointments",
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppointmentsTab.routeName);
                              },
                            ),
                            _SchedulerItem(
                              bgColor: Colors.orange,
                              icon: Icons.home_repair_service_outlined,
                              title: "Service",
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ServiceTab.routeName);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
      );
    });
  }
}

class _SchedulerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Function onTap;

  const _SchedulerItem({this.bgColor, this.icon, this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgColor,
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -50,
              right: -50,
              child: Icon(
                Icons.schedule,
                color: Colors.white38,
                size: 150,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Icon(
                    icon,
                    size: 30,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
