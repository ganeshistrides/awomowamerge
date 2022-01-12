import 'package:awomowa/vendormodule/import_barrel.dart';
import 'package:awomowa/vendormodule/reponse_models/offer_list_response.dart';

class ActiveOfferListProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;

  OfferListResponse offerListResponse;
  String searchString = "";
  String offerListScreen;

  ActiveOfferListProvider() {
    getOfferList();
  }

  Future<void> getOfferList() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "activeBroadcasts",
      "searchString": searchString,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    offerListResponse = OfferListResponse.fromJson(await loadApi(
        params: params,
        apiUrl: OFFER_LIST,
        onError: (e) {
          isError = true;
        }));

    if (offerListResponse.histories == null) {
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
  pageend(){

  }
}
