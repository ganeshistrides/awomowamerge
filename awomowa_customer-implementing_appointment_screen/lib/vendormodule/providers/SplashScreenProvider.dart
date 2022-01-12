import 'package:awomowa/vendormodule/import_barrel.dart';
import 'package:flutter/cupertino.dart';

class SplashScreenProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  Map<String, dynamic> registrationDetailsResponse;

  Future<void> checkRegistrationDetails() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "vendorRegistrationStatus",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    registrationDetailsResponse = await loadApi(
        params: params,
        apiUrl: STATUS,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }
}
