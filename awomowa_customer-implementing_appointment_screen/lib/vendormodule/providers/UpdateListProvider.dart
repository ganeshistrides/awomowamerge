import 'package:awomowa/vendormodule/import_barrel.dart';
import 'package:awomowa/vendormodule/reponse_models/update_list_response.dart';
import 'package:flutter/cupertino.dart';

class UpdateListProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;

  UpdatesListResponse updatesListResponse;

  Future<void> getUpdates() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "vendorUpdateHistory",
      //"pgaeNo":2.toString(),
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    updatesListResponse = UpdatesListResponse.fromJson(await loadApi(
        params: params,
        apiUrl: OFFER_LIST,
        onError: (e) {
          isError = true;
        }));

    if (updatesListResponse.histories == null) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

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
