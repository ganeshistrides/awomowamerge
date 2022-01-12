import 'package:awomowa/vendormodule/import_barrel.dart';
import 'package:flutter/cupertino.dart';

class SubscriptionInfoProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;

  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  SubscriptionInfoResponse subscriptionInfoResponse;

  SubscriptionInfoProvider() {
    getSubscriptionInfo();
  }

  Future<void> getSubscriptionInfo() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "checkPreviousPackage",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    subscriptionInfoResponse = SubscriptionInfoResponse.fromJson(await loadApi(
        params: params,
        apiUrl: PACKAGE,
        onError: (e) {
          isError = true;
        }));

    toggleLoading();
  }
}
