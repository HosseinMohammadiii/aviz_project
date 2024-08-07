import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/DataFuture/NetworkUtil/di.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_bloc.dart';
import 'package:aviz_project/DataFuture/search/Bloc/search_bloc.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/login_screen.dart';
import 'package:aviz_project/screen/register_feature_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DataFuture/ad_details/Bloc/detail_ad_bloc.dart';
import 'DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import 'screen/add_advertising_screen.dart';
import 'widgets/buttomnavigationbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getInInit();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StatusModeBloc(),
        ),
        BlocProvider(
          create: (context) => BoolStateCubit(),
        ),
        BlocProvider(
          create: (context) => NavigationPage(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(
            locator.get(),
          ),
        ),
        BlocProvider(
          create: (context) => SearchBloc(
            locator.get(),
          ),
        ),
        BlocProvider(
          create: (context) => AdFeaturesBloc(
            locator.get(),
          ),
        ),
        BlocProvider(
          create: (context) => AddAdvertisingBloc(
            locator.get(),
            locator.get(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        useMaterial3: true,
        textTheme: TextTheme(
          titleLarge: const TextStyle(
            color: CustomColor.black,
            fontSize: 16,
            fontFamily: 'SN',
            fontWeight: FontWeight.w700,
          ),
          titleMedium: const TextStyle(
            color: CustomColor.grey400,
            fontSize: 14,
            fontFamily: 'SN',
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: const TextStyle(
            color: CustomColor.black,
            fontSize: 14,
            decoration: TextDecoration.none,
            fontFamily: 'SN',
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: 'SN',
            color: CustomColor.grey500,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          labelMedium: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontFamily: 'SN',
            color: CustomColor.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
      home: BottomNavigationScreen(),
    );
  }
}
// LogInScreen()