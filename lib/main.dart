import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:real_their/app.dart';
import 'package:real_their/core/shared_provider/home_screen_provider.dart';
import 'package:real_their/presentation/view_models/favourite_view_model/favourite_view_model.dart';

import 'core/DI/di.dart';
import 'core/api/api_manger.dart';
import 'core/get_current_location.dart';
import 'core/local_storage/shared_pref.dart';
import 'no_internet_app.dart';

Future<void> main() async {
  configureDependencies();
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  bool isConnected = await checkInternet();

  await PrefsHelper.init();
  ApiManager.init();
  await _fetchAndStoreLocation();

  if (isConnected) {
    runApp(AppWrapper());

  } else {
    runApp(NoInternetApp()); // شاشة توضح للمستخدم أنه لا يوجد اتصال
  }
}

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    // متصل بالإنترنت
    return true;
  } else {
    // لا يوجد اتصال
    return false;
  }
}


Future<void> _fetchAndStoreLocation() async {
  final locationHelper = GetCurrentLocation();
  final result = await locationHelper.getCurrentLocationWithCityAndAdminArea();
  final position = result.$1;
  final error = result.$2;
  final city = result.$3;
  final adminArea = result.$4;

  if (position != null && error == null) {
    // اطبع المدينة والمحافظة مع بعض
    print('City: $result');
    print('Admin Area (Province): $adminArea');

    // هنا ممكن تخزنها في Shared Preferences أو تستخدمها بأي طريقة تناسبك
  } else {
    print("Error getting location or permission: $error");
  }
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = PrefsHelper.getUserId();

    if (userId == null) {
      // If no user is logged in, create the app without FavoriteViewModel
      return MultiProvider(
        providers: [
          BlocProvider<FavouriteViewModel>(
            create: (context) => getIt<FavouriteViewModel>(),
          ),
          ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        ],
        child: const App(),
      );
    }

    // If the user is logged in, create the app with FavoriteViewModel
    return MultiProvider(
      providers: [
        BlocProvider<FavouriteViewModel>(
          create: (context) => getIt<FavouriteViewModel>()..getFavourites(userId),
        ),
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
      ],
      child: const App(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
