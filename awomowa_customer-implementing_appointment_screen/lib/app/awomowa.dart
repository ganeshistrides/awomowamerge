import 'dart:convert';

import 'package:awomowa/app/theme.dart';
import 'package:awomowa/model/AboutUsProvider.dart';
import 'package:awomowa/model/AddShopProvider.dart';
import 'package:awomowa/model/DarkThemeProvider.dart';
import 'package:awomowa/model/EditProfileProvider.dart';
import 'package:awomowa/model/ForgotPasswordProvider.dart';
import 'package:awomowa/model/LoginProvider.dart';
import 'package:awomowa/model/ManageStoresProvider.dart';
import 'package:awomowa/model/NotificationListProvider.dart';
import 'package:awomowa/model/OfferDetailsProvider.dart';
import 'package:awomowa/model/OfferListProvider.dart';
import 'package:awomowa/model/ShopOfferProvider.dart';
import 'package:awomowa/model/SignUpProvider.dart';
import 'package:awomowa/model/UpdateDetailsProvider.dart';
import 'package:awomowa/screens/about_us%20_screen.dart';
import 'package:awomowa/screens/add_shop_screen.dart';
import 'package:awomowa/screens/appointment_list_screen.dart';
import 'package:awomowa/screens/edit_profile.dart';
import 'package:awomowa/screens/error_screen.dart';
import 'package:awomowa/screens/forgot_password_screen.dart';
import 'package:awomowa/screens/home_screen.dart';
import 'package:awomowa/screens/login_screen.dart' as Login;
import 'package:awomowa/screens/manage_stores_screen.dart';
import 'package:awomowa/screens/notification_screen.dart';
import 'package:awomowa/screens/offer_details.dart';
import 'package:awomowa/screens/register_screen.dart' as Customersignup;
import 'package:awomowa/screens/register_screen.dart';
import 'package:awomowa/screens/reset_password_screen.dart';
import 'package:awomowa/screens/schedule/appointment_provider.dart';
import 'package:awomowa/screens/schedule/select_vendor_screen.dart';
import 'package:awomowa/screens/schedule_calendar_screen.dart';
import 'package:awomowa/screens/shop_details_screen.dart';
import 'package:awomowa/screens/splash_screen.dart';
import 'package:awomowa/screens/update_details_screen.dart';
import 'package:awomowa/screens/welcome_screen.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:awomowa/vendormodule/providers/AboutUsProvider.dart'
    as Aboutusprovider;
import 'package:awomowa/vendormodule/providers/ActiveOfferListProvider.dart';
import 'package:awomowa/vendormodule/providers/AddNewOfferProvider.dart';
import 'package:awomowa/vendormodule/providers/DarkThemeProvider.dart'
    as Darkthemeprovider;
import 'package:awomowa/vendormodule/providers/EditOfferProvider.dart';
import 'package:awomowa/vendormodule/providers/EditShopInfoProvider.dart';
import 'package:awomowa/vendormodule/providers/ForgotPasswordProvider.dart'
    as Forgetpasswordprovider;
import 'package:awomowa/vendormodule/providers/LoginProvider.dart'
    as Loginprovider;
import 'package:awomowa/vendormodule/providers/ManageOffersProvider.dart';
import 'package:awomowa/vendormodule/providers/PackageDetailsProvider.dart';
import 'package:awomowa/screens/about_us _screen.dart';
import 'package:awomowa/vendormodule/screens/about_us _screen.dart' as Aboutusscreen;

import 'package:awomowa/vendormodule/providers/SettingsProvider.dart';
import 'package:awomowa/vendormodule/providers/SignUpProvider.dart'
    as Signupprovider;
import 'package:awomowa/vendormodule/providers/SubscriptionInfoProvider.dart';
import 'package:awomowa/vendormodule/providers/ThemeColorProvider.dart';
import 'package:awomowa/vendormodule/providers/TransactionHistoryProvider.dart';
import 'package:awomowa/vendormodule/providers/UpdateListProvider.dart';
import 'package:awomowa/vendormodule/providers/UserDetailsProvider.dart';
import 'package:awomowa/vendormodule/providers/VendorDetailsProvider.dart';
import 'package:awomowa/vendormodule/screens/active_offer_details.dart';
import 'package:awomowa/vendormodule/screens/approval_screen.dart';
import 'package:awomowa/vendormodule/screens/color_picker_screen.dart';
import 'package:awomowa/vendormodule/screens/edit_shop_info_screen.dart';
import 'package:awomowa/vendormodule/screens/forgot_password_screen.dart'
    as Forgetpassword;
import 'package:awomowa/vendormodule/screens/home_screen.dart' as Vendor;
import 'package:awomowa/vendormodule/screens/login_screen.dart' as Vendorlogin;
import 'package:awomowa/vendormodule/screens/manage_offers_screen.dart';
import 'package:awomowa/vendormodule/screens/new_offer.dart';
import 'package:awomowa/vendormodule/screens/package_screen.dart';
import 'package:awomowa/vendormodule/screens/payment_success_screen.dart';
import 'package:awomowa/vendormodule/screens/publish_success_screen.dart';
import 'package:awomowa/vendormodule/screens/reset_password_screen.dart'
    as Resetpassword;


import 'package:awomowa/vendormodule/screens/scheduler/scheduler_provider.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_screen.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/appointments/appointments_tab.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/appointments/appointments_tab_provider.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/calendar/calendar_tab.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/calendar/calendar_tab_provider.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/service/service_tab.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/service/service_tab_provider.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/slots/slots_tab.dart';
import 'package:awomowa/vendormodule/screens/scheduler/scheduler_tabs/slots/slots_tab_provider.dart';
import 'package:awomowa/vendormodule/screens/shop_details_screen.dart'
    as Vendorshopdetail;
import 'package:awomowa/vendormodule/screens/signup_screen.dart'
    as vendorsignup;
import 'package:awomowa/vendormodule/screens/subscription_info_screen.dart';
import 'package:awomowa/vendormodule/screens/transaction_history_screen.dart';
import 'package:awomowa/vendormodule/screens/update_list_screen.dart';
import 'package:awomowa/vendormodule/screens/user_register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Awomowa extends StatefulWidget {
  @override
  _AwomowaState createState() => _AwomowaState();
}

DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

void getCurrentAppTheme() async {
  themeChangeProvider.darkTheme =
      await themeChangeProvider.darkThemePreference.getTheme();
}

class _AwomowaState extends State<Awomowa> {
  FirebaseMessaging messaging;
  // AndroidNotificationChannel channel;
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  setupNotification() async {
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;

    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    messaging.getToken().then((value) {
      print(value);
    });

    // FirebaseMessaging.onBackgroundMessage(_messageHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("$message weeeeeee");

      final Map<String, dynamic> messageObject =
          jsonDecode(message.data['message'].toString());

      print(messageObject.toString());
      if (messageObject['broadcastType'] == 'offer') {
        Navigator.push(
            navigatorKey.currentContext,
            MaterialPageRoute(
                builder: (context) => OfferDetails(
                      shopId: messageObject['shopId'].toString(),
                      broadcastId: messageObject['broadcastId'].toString(),
                    )));
      } else if (messageObject['broadcastType'] == 'userUpcoming') {
        setIndex("userUpcoming");

        Navigator.push(navigatorKey.currentContext,
            MaterialPageRoute(builder: (context) => AppointmentListScreen()));
      } else if (messageObject['broadcastType'] == 'userHistory') {
        setIndex("userHistory");
        Navigator.push(navigatorKey.currentContext,
            MaterialPageRoute(builder: (context) => AppointmentListScreen()));
      } else if (messageObject['broadcastType'] == 'vendorHistory') {
        setIndex("vendorHistory");
        Navigator.push(navigatorKey.currentContext,
            MaterialPageRoute(builder: (context) => AppointmentsTab()));
      } else if (messageObject['broadcastType'] == 'vendorUpcoming') {
        setIndex("vendorUpcoming");
        Navigator.push(navigatorKey.currentContext,
            MaterialPageRoute(builder: (context) => AppointmentsTab()));
      } else {
        Navigator.push(
            navigatorKey.currentContext,
            MaterialPageRoute(
                builder: (context) => UpdateDetails(
                      broadCastId: messageObject['broadcastId'].toString(),
                    )));
      }
    });
  }

  void setIndex(String type) {
    if (type == "userHistory") {
      navigatorKey.currentContext.read<AppointmentsProvider>().currentIndex = 1;
    } else if (type == "userUpcoming") {
      navigatorKey.currentContext.read<AppointmentsProvider>().currentIndex = 0;
    } else if (type == "vendorHistory") {
      navigatorKey.currentContext.read<AppointmentsTabProvider>().currentIndex =
          1;
    } else if (type == "vendorUpcoming") {
      navigatorKey.currentContext.read<AppointmentsTabProvider>().currentIndex =
          0;
    }
    setState(() {});
  }

  @override
  void initState() {
    setupNotification();
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkThemeProvider>(
            create: (context) => themeChangeProvider),
        ChangeNotifierProvider<SignUpProvider>(
            create: (context) => SignUpProvider()),
        ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider()),
        ChangeNotifierProvider<OfferListProvider>(
            create: (context) => OfferListProvider()),
        ChangeNotifierProvider<OfferDetailsProvider>(
            create: (context) => OfferDetailsProvider("", "")),
        ChangeNotifierProvider<NotificationListProvider>(
            create: (context) => NotificationListProvider()),
        ChangeNotifierProvider<AboutUsProvider>(
            create: (context) => AboutUsProvider()),
        ChangeNotifierProvider<AddShopProvider>(
            create: (context) => AddShopProvider()),
        ChangeNotifierProvider<ManageShopsProvider>(
            create: (context) => ManageShopsProvider()),
        ChangeNotifierProvider<ForgotPasswordProvider>(
            create: (context) => ForgotPasswordProvider()),
        ChangeNotifierProvider<EditProfileProvider>(
            create: (context) => EditProfileProvider()),
        ChangeNotifierProvider<UpdateDetailsProvider>(
            create: (context) => UpdateDetailsProvider()),
        ChangeNotifierProvider<ShopOfferProvider>(
            create: (context) => ShopOfferProvider()),
        ChangeNotifierProvider<AppointmentsProvider>(
            create: (context) => AppointmentsProvider()),
        ChangeNotifierProvider<Darkthemeprovider.DarkThemeProvider>(
            create: (context) => Darkthemeprovider.DarkThemeProvider()),
        ChangeNotifierProvider<Loginprovider.LoginProvider>(
            create: (context) => Loginprovider.LoginProvider()),
        ChangeNotifierProvider<Signupprovider.SignUpProvider>(
            create: (context) => Signupprovider.SignUpProvider()),
        ChangeNotifierProvider<PackageDetailsProvider>(
            create: (context) => PackageDetailsProvider()),
        ChangeNotifierProvider<UserDetailsProvider>(
            create: (context) => UserDetailsProvider()),
        ChangeNotifierProvider<VendorDetailsProvider>(
            create: (context) => VendorDetailsProvider()),
        ChangeNotifierProvider<TransactionHistoryProvider>(
            create: (context) => TransactionHistoryProvider()),
        ChangeNotifierProvider<AddNewOfferProvider>(
            create: (context) => AddNewOfferProvider()),
        ChangeNotifierProvider<SettingsProvider>(
            create: (context) => SettingsProvider()),
        ChangeNotifierProvider<ActiveOfferListProvider>(
            create: (context) => ActiveOfferListProvider()),
        ChangeNotifierProvider<Aboutusprovider.AboutUsProvider>(
            create: (context) => Aboutusprovider.AboutUsProvider()),
        ChangeNotifierProvider<ManageOffersProvider>(
            create: (context) => ManageOffersProvider()),
        ChangeNotifierProvider<EditOfferProvider>(
            create: (context) => EditOfferProvider()),
        ChangeNotifierProvider<EditShopInfoProvider>(
            create: (context) => EditShopInfoProvider()),
        ChangeNotifierProvider<SubscriptionInfoProvider>(
            create: (context) => SubscriptionInfoProvider()),
        ChangeNotifierProvider<Forgetpasswordprovider.ForgotPasswordProvider>(
            create: (context) =>
                Forgetpasswordprovider.ForgotPasswordProvider()),
        ChangeNotifierProvider<UpdateListProvider>(
            create: (context) => UpdateListProvider()),
        ChangeNotifierProvider<ThemeColorProvider>(
            create: (context) => ThemeColorProvider()),
        ChangeNotifierProvider<SchedulerProvider>(
            create: (context) => SchedulerProvider()),
        ChangeNotifierProvider<ServiceTabProvider>(
            create: (context) => ServiceTabProvider()),
        ChangeNotifierProvider<AppointmentsTabProvider>(
            create: (context) => AppointmentsTabProvider()),
        ChangeNotifierProvider<SlotsTabProvider>(
            create: (context) => SlotsTabProvider()),
        ChangeNotifierProvider<CalendarTabProvider>(
            create: (context) => CalendarTabProvider()),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                themeMode: themeChangeProvider.darkTheme
                    ? ThemeMode.dark
                    : ThemeMode.light,
                theme: AppTheme.light(),
                darkTheme: AppTheme.dark(),
                home: SplashScreen(),
                routes: {
                  Login.LoginScreen.routeName: (context) => Login.LoginScreen(),
                  RegisterScreen.routeName: (context) => RegisterScreen(),
                  HomeScreen.routeName: (context) => HomeScreen(),
                  AddShopScreen.routeName: (context) => AddShopScreen(),
                  ForgotPasswordScreen.routeName: (context) =>
                      ForgotPasswordScreen(),
                  NotificationsScreen.routeName: (context) =>
                      NotificationsScreen(),
                  OfferDetails.routeName: (context) => OfferDetails(),
                  AboutUs.routeName: (context) => AboutUs(),
                  ShopDetails.routeName: (context) => ShopDetails(),
                  ManageStoresScreen.routeName: (context) =>
                      ManageStoresScreen(),
                  WelcomeScreen.routeName: (context) => WelcomeScreen(),
                  ProfileScreen.routeName: (context) => ProfileScreen(),
                  NoInternet.routeName: (context) => NoInternet(),
                  ResetPasswordScreen.routeName: (context) =>
                      ResetPasswordScreen(),
                  ScheduleCalendarScreen.routeName: (context) =>
                      ScheduleCalendarScreen(),
                  SelectVendorScreen.routeName: (context) =>
                      SelectVendorScreen(),
                  PackageScreen.routeName: (context) => PackageScreen(),
                  Vendorlogin.LoginScreen.routeName: (context) =>
                      Vendorlogin.LoginScreen(),
                  vendorsignup.SignUpScreen.routeName: (context) =>
                      vendorsignup.SignUpScreen(),
                  //SignUpScreen.routeName: (context) => SignUpScreen(),
                  Customersignup.RegisterScreen.routeName: (context) =>
                      Customersignup.RegisterScreen(),
                  PackageScreen.routeName: (context) => PackageScreen(),
                  PaymentSuccessScreen.routeName: (context) =>
                      PaymentSuccessScreen(),
                  Vendor.HomeScreen.routeName: (context) => Vendor.HomeScreen(),
                  Vendorshopdetail.ShopDetails.routeName: (context) =>
                      Vendorshopdetail.ShopDetails(),
                Aboutusscreen.AboutUs.routeName: (context) => Aboutusscreen.AboutUs(),
                  NewOfferScreen.routeName: (context) => NewOfferScreen(),
                  PublishSuccessScreen.routeName: (context) =>
                      PublishSuccessScreen(),
                  Forgetpassword.ForgotPasswordScreen.routeName: (context) =>
                      Forgetpassword.ForgotPasswordScreen(),
                  Resetpassword.ResetPasswordScreen.routeName: (context) =>
                      Resetpassword.ResetPasswordScreen(),
                  ActiveOfferDetails.routeName: (context) =>
                      ActiveOfferDetails(),
                  ApprovalScreen.routeName: (context) => ApprovalScreen(),
                  ManageOffersScreen.routeName: (context) =>
                      ManageOffersScreen(),
                  UserDetailsScreen.routeName: (context) => UserDetailsScreen(),
                  SubscriptionInfoScreen.routeName: (context) =>
                      SubscriptionInfoScreen(),
                  EditShopInfo.routeName: (context) => EditShopInfo(),
                  UpdatesListScreen.routeName: (context) => UpdatesListScreen(),
                  ColorPickerScreen.routeName: (context) => ColorPickerScreen(),
                  TransactionHistoryScreen.routeName: (context) =>
                      TransactionHistoryScreen(),
                  SchedulerScreen.routeName: (context) => SchedulerScreen(),
                  ServiceTab.routeName: (context) => ServiceTab(),
                  AppointmentsTab.routeName: (context) => AppointmentsTab(),
                  SlotsTab.routeName: (context) => SlotsTab(),
                  CalendarTab.routeName: (context) => CalendarTab()
                },
              );
            },
          );
        },
      ),
    );
  }
}
