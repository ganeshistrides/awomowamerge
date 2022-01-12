import 'package:awomowa/vendormodule/import_barrel.dart';

class AboutUsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;
  AbutUsResponse aboutUsResponse;

  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  AboutUsProvider() {
    getAboutUsContent();
  }

  Future<void> getAboutUsContent() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "appContent",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    aboutUsResponse = AbutUsResponse.fromJson(await loadApi(
        params: params,
        apiUrl: ABOUT_US,
        onError: (e) {
          isError = true;
        }));

    if (aboutUsResponse == null) {
      isEmpty = true;
    }

    toggleLoading();
  }
}
