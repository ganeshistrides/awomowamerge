import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static const THEME_STATUS = "THEMESTATUS";
  static const AUTH_KEY = "authkey";
  static const IS_LOGGED_IN = "isloggedin";
  static const USER_NAME = "username";
  static const GENDER = "gender";
  static const DOB = "dateofbirth";
  static const EMAIL = "email1";
  var re, res;
  static const MOBILENUMBER = "mobilenm";
  static const PIC = "pic";
  static const ISNEWNOTIFICATIONCAME = "isnewnoticc";
  static bool isNewNotified = false;
  static const ACCESS = "user1";
  static const CUSTOMERROLE = "customerrole";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(THEME_STATUS) ?? false;
  }

  setAuthKey(String authKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AUTH_KEY, authKey);
  }

  Future<String> getAuthKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AUTH_KEY) ?? null;
  }

  setNewNotification(bool isnewNotificationCame) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(ISNEWNOTIFICATIONCAME, isnewNotificationCame);
  }

  Future<bool> isNewNotificationCame() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(ISNEWNOTIFICATIONCAME) ?? true;
  }

  setLoggedIn(bool isloggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_LOGGED_IN, isloggedIn);
  }

  Future<bool> getLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_LOGGED_IN) ?? false;
  }

  setUsername(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_NAME, name);
  }

  Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_NAME) ?? 'john doe';
  }

  setCustomer(String customer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ACCESS, customer);
  }

  Future<String> getCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return re = prefs.getString(ACCESS) ?? '';
//    return prefs.getString(ACCESS) ?? '';
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  setEmail(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EMAIL, name);
  }

  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(EMAIL) ?? '';
  }

  setMobile(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(MOBILENUMBER, mobile);
  }

  Future<String> getMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(MOBILENUMBER) ?? '';
  }

  setDob(String dob) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(DOB, dob);
  }

  Future<String> getDob() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DOB) ?? '';
  }

  setGender(String gender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(GENDER, gender);
  }

  Future<String> getGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(GENDER) ?? '';
  }

  setProfilePic(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PIC, url);
  }

  Future<String> getProfilePic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PIC) ?? '';
  }

  static const VENDOR_THEME_STATUS = "THEMESTATUS";
  static const VENDOR_AUTH_KEY = "vendorauthkey";
  static const VENDOR_IS_LOGGED_IN = "vendorisloggedin";
  static const VENDOR_SHOP_NAME = "vendorshopName";
  static const VENDOR_CATEGORY = "vendorcategory";
  static const VENDOR_DOB = "vendordateofbirth";
  static const VENDOR_EMAIL = "vendoremail";
  static const VENDOR_MOBILENUMBER = "vendormobilenm";
  static const VENDOR_LOGO = "vendorpic";
  static const VENDOR_IS_SUBSCRIPTION_ACTIVE = "vendorSUBSACTIVE";
  static const VENDOR_SUBS_REMAINING_DAYS = "vendorREMAININGDAYS";
  static bool VENDOR_isNewNotified = false;

  static const VENDOR_ISALLOWTORENEW = "vendorallowtorenew";
  static const ACCESSVENDOR = "merchant";

  setvendorAuthKey(String authKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(VENDOR_AUTH_KEY, authKey);
  }

  setVendor(String merchant) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ACCESSVENDOR, merchant);
  }

  Future<String> getVendor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return res = prefs.getString(ACCESSVENDOR) ?? '';
//    return prefs.getString(ACCESS) ?? '';
  }

  setIsSubscribed(bool isSubscribed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(VENDOR_IS_SUBSCRIPTION_ACTIVE, isSubscribed ?? false);
  }

  Future<bool> isSubsActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(VENDOR_IS_SUBSCRIPTION_ACTIVE) ?? false;
  }

  setRemainingDays(String days) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt(VENDOR_SUBS_REMAINING_DAYS, int.parse(days) ?? 0);
  }

  Future<int> getRemainingDays() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(VENDOR_SUBS_REMAINING_DAYS) ?? 0;
  }

  setAllowToRenewal(bool allow) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(VENDOR_ISALLOWTORENEW, allow);
  }

  Future<bool> isAllowToRenew() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(VENDOR_ISALLOWTORENEW) ?? false;
  }

  setShopName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(VENDOR_SHOP_NAME, name);
  }

  Future<String> getShopName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(VENDOR_SHOP_NAME) ?? '';
  }

  setShopCategory(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(VENDOR_CATEGORY, url);
  }

  Future<String> getShopCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(VENDOR_CATEGORY) ?? '';
  }

  setShopLogo(String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(VENDOR_CATEGORY, category);
  }

  Future<String> getShopLogo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(VENDOR_LOGO) ?? '';
  }

  Future<void> vendorLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  setVendorEmail(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(VENDOR_EMAIL, name);
  }

  Future<String> getVendorEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(VENDOR_EMAIL) ?? '';
  }

  setVendorMobile(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(VENDOR_MOBILENUMBER, mobile);
  }

  Future<String> getVendorMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(VENDOR_MOBILENUMBER) ?? '';
  }

  setVendorLoggedIn(bool vendorisloggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(VENDOR_IS_LOGGED_IN, vendorisloggedIn);
  }

  Future<bool> getVendorLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(VENDOR_IS_LOGGED_IN) ?? false;
  }
}
