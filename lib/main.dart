import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:real_their/app.dart';
import 'package:real_their/core/shared_provider/home_screen_provider.dart';


import 'core/DI/di.dart';
import 'core/api/api_manger.dart';
import 'core/local_storage/shared_pref.dart';

Future<void> main() async {
  configureDependencies();
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await PrefsHelper.init();
  ApiManager.init();
  runApp(ChangeNotifierProvider(
    child: const App(),
    create:(context) =>  HomeScreenProvider(),
  )
  );
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}