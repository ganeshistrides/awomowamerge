import 'package:awomowa/utils/app_utils.dart';
import 'package:awomowa/vendormodule/https/model/service/service_response.dart';
import 'package:awomowa/vendormodule/https/repository/scheduler_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceTabProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Service> serviceProvided = [];
  final addServiceContoller = TextEditingController();

//Get ALl Service
  Future<void> init() async {
    serviceProvided.clear();
    addServiceContoller.clear();
    isLoading = true;
    final response = await SchedulerRepository.getAllServices();
    if (response.status == 'success') {
      serviceProvided.addAll(response.availableServices);
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      AppUtils.showToast(response.message, color: Colors.red);

      notifyListeners();
    }
  }

//Add Service
  Future<void> addService(BuildContext context) async {
    if (addServiceContoller.text.isEmpty) {
      AppUtils.showToast("Service Name is Required", color: Colors.red);
      return;
    }
    final response =
        await SchedulerRepository.addService(addServiceContoller.text);
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

  //Delete Service
  Future<void> deleteService(String id) async {
    final response = await SchedulerRepository.deleteService(id);
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
