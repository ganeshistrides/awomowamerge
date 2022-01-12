import 'package:awomowa/vendormodule/import_barrel.dart';
import 'package:flutter/foundation.dart';

class TransactionHistoryProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;

  TransactionHistoryResponse transactionHistoryResponse;

  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  Future<void> getHistory() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "packageHistory",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    transactionHistoryResponse =
        TransactionHistoryResponse.fromJson(await loadApi(
            params: params,
            apiUrl: PAYMENT_HISTORY,
            onError: (e) {
              isError = true;
            }));

    if (transactionHistoryResponse.transactionHistory == null) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

    toggleLoading();
  }
}
