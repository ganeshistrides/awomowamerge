
import 'package:awomowa/vendormodule/https/model/service/service_response.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/service/service_tab_provider.dart';
import 'package:awomowa/vendormodule/widgets/common/custom_alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../import_barrel.dart';

class ServiceTab extends StatefulWidget {
  const ServiceTab({Key key}) : super(key: key);

  static const routeName = 'serviceTab';

  @override
  _ServiceTabState createState() => _ServiceTabState();
}

class _ServiceTabState extends State<ServiceTab> {
  @override
  void initState() {
    final provider = context.read<ServiceTabProvider>();

    provider.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceTabProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Services Provided'),
        ),
        floatingActionButton: _FloatingButton(),
        body: provider.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.serviceProvided.isEmpty
                ? Center(
                    child: Text(
                    "There is No Service Available",
                    style: TextStyle(fontSize: 20),
                  ))
                : Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                return _BuildServiceProvidedCard(
                                    provider.serviceProvided[index]);
                              },
                              itemCount: provider.serviceProvided.length))
                    ],
                  ),
      );
    });
  }
}

//Service Provided Card

class _BuildServiceProvidedCard extends StatelessWidget {
  final Service service;
  const _BuildServiceProvidedCard(this.service);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ServiceTabProvider>();

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
        children: [
          Text(
            service.serviceName,
            style: TextStyle(fontSize: 16),
          ),
          GestureDetector(
            onTap: () {
              CustomAlertDialog.showdialog(
                  context: context,
                  title: "Confirmation Dialog",
                  type: AlertType.warning,
                  description: "Are you sure you want to delete this Service",
                  positiveText: "Yes",
                  negativeText: "No",
                  positiveFunction: () {
                    provider.deleteService(service.serviceId);
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
          ),
        ],
      ),
    );
  }
}

//Add Service

class _FloatingButton extends StatelessWidget {
  const _FloatingButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ServiceTabProvider>();
    return FloatingActionButton(
        onPressed: () {
          provider.addServiceContoller.clear();
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Add Service",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GlobalFormField(
                          hint: 'Service Name',
                          prefixIcon: Icons.help,
                          controller: provider.addServiceContoller,
                          validator: (value) {
                            if (value.length < 1) {
                              return 'Please Enter Valid Service Name';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LoaderButton(
                          onPressed: () {
                            provider.addService(context);
                          },
                          btnTxt: 'Add Service',
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
}
