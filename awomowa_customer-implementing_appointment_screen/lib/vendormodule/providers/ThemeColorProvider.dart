import 'package:awomowa/vendormodule/import_barrel.dart';
import 'package:flutter/cupertino.dart';

class ThemeColorProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;

  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  Map<String, dynamic> updateThemeResponse;

  updateColor(String colorCode) async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "vendorColorCodeUpdate",
      "appColorCode": colorCode,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    updateThemeResponse = await loadApi(
        params: params,
        apiUrl: COLOR_UPDATE,
        onError: (e) {
          isError = true;
        });

    if (updateThemeResponse == null) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

    toggleLoading();
  }
}
