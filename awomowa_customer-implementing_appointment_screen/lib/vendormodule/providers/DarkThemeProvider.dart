import 'package:awomowa/vendormodule/import_barrel.dart';

class DarkThemeProvider with ChangeNotifier {
  SharedPrefManager darkThemePreference = SharedPrefManager();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}
