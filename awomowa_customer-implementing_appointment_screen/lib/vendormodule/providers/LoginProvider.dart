import 'package:awomowa/responsemodels/appointment/generic/generic_response.dart';
import 'package:awomowa/vendormodule/import_barrel.dart';
import 'package:awomowa/vendormodule/reponse_models/login_response.dart';
import 'package:awomowa/vendormodule/screens/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  FirebaseMessaging messaging;

  LoginResponse loginResponse;

  Future<void> signIn(String mobileNumber, String password) async {
    toggleLoading();
    messaging = FirebaseMessaging.instance;
    Map<String, String> params = {
      "apiMethod": "merchantLogin",
      "username": mobileNumber,
      "notificationKey": await messaging.getToken(),
      "password": password,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    loginResponse = LoginResponse.fromJson(await loadApi(
        params: params,
        apiUrl: SIGN_IN,
        onError: (e) {
          isError = true;
        }));

    toggleLoading();
  }

  Future<void> signOut(BuildContext context) async {
    toggleLoading();
    messaging = FirebaseMessaging.instance;
    Map<String, String> params = {
      "apiMethod": "vendorLogout",
      "notificationKey": await messaging.getToken(),
    };

    final response = GenericResponse.fromJson(await loadApi(
        params: params,
        apiUrl: SIGN_OUT,
        onError: (e) {
          isError = true;
        }));
    SharedPrefManager prefManager = SharedPrefManager();
    await messaging.deleteToken();
    await prefManager.vendorLogout();

    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => LoginScreen(),
      ),
      (route) => false, //if you want to disable back feature set to false
    );

    toggleLoading();
  }

  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }
}
