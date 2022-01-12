
import 'package:awomowa/vendormodule/https/model/slots/slots_response.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/slots/slots_tab_provider.dart';
import 'package:awomowa/vendormodule/time_utils.dart';
import 'package:awomowa/vendormodule/widgets/common/custom_time_range_picker.dart';
import 'package:awomowa/vendormodule/widgets/form_field.dart';
import 'package:awomowa/vendormodule/widgets/loader_button.dart';
import 'package:awomowa/widgets/common/custom_alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SlotsTab extends StatefulWidget {
  static const routeName = 'slotsTab';

  const SlotsTab({Key key}) : super(key: key);

  @override
  _SlotsTabState createState() => _SlotsTabState();
}

class _SlotsTabState extends State<SlotsTab> {
  @override
  void initState() {
    final provider = context.read<SlotsTabProvider>();
    provider.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SlotsTabProvider>(builder: (context, provider, child) {
      return Scaffold(
        floatingActionButton: _BuildFloatingButton(),
        appBar: AppBar(
          title: Text("Slots"),
        ),
        body: provider.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.slotGroups.isEmpty
                ? Center(
                    child: Text(
                      "There is No Slots Available",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                      right: 15,
                      left: 15,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                          itemBuilder: (context, index) {
                            return _BuildSlotsCard(
                                slotsGroups: provider.slotGroups[index]);
                          },
                          itemCount: provider.slotGroups.length,
                        ))
                      ],
                    ),
                  ),
      );
    });
  }
}

//Slots Cards
class _BuildSlotsCard extends StatelessWidget {
  final SlotsGroups slotsGroups;
  final bool isCreateSlots;
  const _BuildSlotsCard({this.isCreateSlots = false, this.slotsGroups});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SlotsTabProvider>();

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!isCreateSlots)
                Text(slotsGroups.groupName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
              else
                Text(provider.addSlotNameContoller.text,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              if (isCreateSlots && provider.slots.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        provider.clearSlots();
                      },
                      child: Text(
                        "Clear All",
                        style: TextStyle(color: Colors.blue[300]),
                      ),
                    ),
                  ],
                ),
              if (!isCreateSlots)
                GestureDetector(
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
                          provider.deleteSlotGroups(slotsGroups.groupId);
                          Navigator.pop(context);
                        },
                        negativeFunction: () {
                          Navigator.pop(context);
                        });
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 10,
            children: isCreateSlots
                ? List.generate(
                    provider.slots.length,
                    (index) => Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, right: 15, left: 15),
                      child: Text(getTime(provider.slots[index].startTime,
                          provider.slots[index].endTime)),
                    ),
                  )
                : List.generate(
                    slotsGroups.availSlots.length,
                    (index) => Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, right: 15, left: 15),
                      child: Text(getTime(
                          TimeUtils.convertTimeofDay(
                              slotsGroups.availSlots[index].startTime),
                          TimeUtils.convertTimeofDay(
                              slotsGroups.availSlots[index].endTime))),
                    ),
                  ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  String getTime(TimeOfDay startTime, TimeOfDay endTime) {
    return "${TimeUtils.convertAmPM(TimeUtils.convertHIS(startTime))} - ${TimeUtils.convertAmPM(TimeUtils.convertHIS(endTime))} ";
  }
}

//Add Slots

class _BuildFloatingButton extends StatelessWidget {
  const _BuildFloatingButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SlotsTabProvider>();

    return FloatingActionButton(
        onPressed: () {
          provider.addSlotNameContoller.clear();
          provider.timeRangeValue = null;
          provider.slots.clear();
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "New Slot",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GlobalFormField(
                          hint: 'Slot Name',
                          prefixIcon: Icons.help,
                          controller: provider.addSlotNameContoller,
                          validator: (value) {
                            if (value.length < 1) {
                              return 'Please Enter Valid Slot Name';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  provider.startTime = null;
                                  provider.endTime = null;
                                  TimeRangePicker.show(
                                    context: context,
                                    headerDefaultStartLabel: "Start Time",
                                    headerDefaultEndLabel: "End Time",
                                    unSelectedEmpty: true,
                                    startTime: provider.startTime,
                                    endTime: provider.endTime,
                                    onStartTimeChange: (value) {
                                      provider.startTime = value;
                                    },
                                    onEndTimeChange: (value) {
                                      provider.endTime = value;
                                    },
                                    autoAdjust: false,
                                    onSubmitted: (TimeRangeValue value) {
                                      provider.pickStartTimeAndEndTime(value);
                                    },
                                  );
                                },
                                child:
                                    Selector<SlotsTabProvider, TimeRangeValue>(
                                  builder: (context, value, child) {
                                    return Container(
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 15,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Colors.grey, width: 0.5)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.schedule,
                                            size: 15,
                                          ),
                                          const SizedBox(width: 15),
                                          Text(
                                            getTime(value),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  selector: (context, provider) =>
                                      provider.timeRangeValue,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                provider.addSlots();
                              },
                              child: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, right: 15, left: 15),
                                decoration: BoxDecoration(
                                    color: const Color(0xffFFC324),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      width: 0.5,
                                      color: const Color(0xffFFC324),
                                    )),
                                child: Center(
                                  child: Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Selector<SlotsTabProvider, bool>(
                            builder: (context, value, child) {
                              return value
                                  ? Container()
                                  : _BuildSlotsCard(isCreateSlots: true);
                            },
                            selector: (context, provider) =>
                                provider.slots.isEmpty),
                        const SizedBox(
                          height: 15,
                        ),
                        LoaderButton(
                          onPressed: () {
                            provider.addSlotGroup(context);
                          },
                          btnTxt: 'Create Slot',
                          isLoading: provider.isLoading,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        backgroundColor: const Color(0xffFFC324),
        child: Icon(Icons.add));
  }

  String getTime(TimeRangeValue value) {
    if (value != null) {
      return "${TimeUtils.convertAmPM(TimeUtils.convertHIS(value.startTime))} - ${TimeUtils.convertAmPM(TimeUtils.convertHIS(value.endTime))} ";
    } else {
      return "Slot Time";
    }
  }
}
