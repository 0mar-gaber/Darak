import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:real_their/app.dart';
import 'package:real_their/core/shared_provider/home_screen_provider.dart';
import 'package:real_their/presentation/view_models/favourite_view_model/favourite_view_model.dart';

import 'core/DI/di.dart';
import 'core/api/api_manger.dart';
import 'core/local_storage/shared_pref.dart';

Future<void> main() async {
  configureDependencies();
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await PrefsHelper.init();
  ApiManager.init();

  runApp(AppWrapper());
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
