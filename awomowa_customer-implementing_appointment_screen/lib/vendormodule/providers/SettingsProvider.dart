import 'package:awomowa/vendormodule/import_barrel.dart';
import 'package:flutter/foundation.dart';

class SettingsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String shopName = '';
  String category = '';
  String logoUrl = '';
  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  SettingsProvider() {
    getShopDetails();
  }
  VendorDetailsResponse vendorDetailsResponse;

  getShopDetails() async {
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

    shopName = vendorDetailsResponse.merchantInformations.shopName;
    category = vendorDetailsResponse.merchantInformations.shopCategoryName;
    logoUrl = vendorDetailsResponse.merchantInformations.shopLogo;

    toggleLoading();
  }
}
