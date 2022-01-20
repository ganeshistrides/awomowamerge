
import 'package:awomowa/vendormodule/import_barrel.dart';
import 'package:flutter/cupertino.dart';

class VendorDetailsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  VendorDetailsResponse vendorDetailsResponse;

  SharedPrefManager darkThemePreference = SharedPrefManager();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }

  Future<void> getVendorDetails() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "merchantDetails",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };
    vendorDetailsResponse = VendorDetailsResponse.fromJson(await loadApi(
        params: params,
        apiUrl: VENDOR_DETAILS,
        onError: (e) {
          isError = true;
        }));

    if (vendorDetailsResponse.status == 'success') {
      SharedPrefManager prefManger = SharedPrefManager();
      prefManger.setVendorLoggedIn(true);
      prefManger
          .setVendorEmail(vendorDetailsResponse.merchantInformations.shopMailId);
      prefManger.setVendorMobile(
          vendorDetailsResponse.merchantInformations.shopContactNumber);

      //TODO change default values of subscription
      prefManger.setIsSubscribed(
          vendorDetailsResponse.merchantInformations.isSubscriptionActive ==
              'yes');
      print(
          vendorDetailsResponse.merchantInformations.subscriptionRemainingDays);
      prefManger.setRemainingDays(
          vendorDetailsResponse.merchantInformations.subscriptionRemainingDays);
      prefManger.setAllowToRenewal(
          vendorDetailsResponse.merchantInformations.isAllowToRenewal == 'yes');
      // prefManger.setRemainingDays("28");
    }

    toggleLoading();
  }
}
