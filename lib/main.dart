import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/DataFuture/NetworkUtil/authmanager.dart';
import 'package:aviz_project/DataFuture/NetworkUtil/di.dart';
import 'package:aviz_project/DataFuture/account/Bloc/account_bloc.dart';
import 'package:aviz_project/DataFuture/advertising_save/bloc/advertising_save_bloc.dart';

import 'package:aviz_project/DataFuture/home/Bloc/home_bloc.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_event.dart';
import 'package:aviz_project/DataFuture/province/Bloc/province_bloc.dart';
import 'package:aviz_project/DataFuture/recent/bloc/recent_bloc.dart';
import 'package:aviz_project/DataFuture/search/Bloc/search_bloc.dart';
import 'package:aviz_project/Hive/Advertising/advertising_hive.dart';
import 'package:aviz_project/Hive/UsersLogin/user_login.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/initial.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'DataFuture/account/Bloc/account_event.dart';
import 'DataFuture/ad_details/Bloc/detail_ad_bloc.dart';
import 'DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';

import 'DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import 'class/firebase_messsaging.dart';
import 'widgets/buttomnavigationbar.dart';

void main() async {
  // Ensures that Flutter's widget binding is properly initialized.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initializes Hive for local storage.
  await Hive.initFlutter();
  
  // Sets up Firebase Messaging for handling push notifications.
  FirebaseMessagingService.initialize();

  // Registers Hive adapters for custom data types.
  Hive.registerAdapter(UserLoginAdapter());

  Hive.registerAdapter(AdvertisingHiveAdapter());

  // Opens Hive boxes for user login data and advertisements.
  await Hive.openBox<UserLogin>('user_login');

  await Hive.openBox<AdvertisingHive>('ad_hive');

  // Registers services and repositories with GetIt dependency injection.
  await getInInit();

  // Runs the Flutter app with multiple Bloc providers.
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
          create: (context) => RegisterInfoAdCubit(),
        ),
        BlocProvider(
          create: (context) => NavigationPage(),
        ),
        BlocProvider(
          create: (context) => AuthAccountBloc(
            locator.get(),
          ),
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
          create: (context) => AdHomeFeaturesBloc(
            locator.get(),
          ),
        ),
        BlocProvider(
          create: (context) => AdImagesHomeBloc(
            locator.get(),
          ),
        ),
        BlocProvider(
          create: (context) => AddAdvertisingBloc(
            locator.get(),
          ),
        ),
        BlocProvider(
          create: (context) => RecentBloc(
            locator.get(),
          ),
        ),
        BlocProvider(
          create: (context) => SaveAdBloc(
            locator.get(),
          ),
        ),
        BlocProvider(
          create: (context) => ProvinceBloc(),
        ),
        BlocProvider(
          create: (context) => AdExistsBloc(
            locator.get(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// Route observer to monitor navigation between pages.
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Triggers the event to fetch home page data on app launch.
    context.read<HomeBloc>().add(HomeGetInitializeData());
    
    // Initializes display settings for advertising.
    context.read<AddAdvertisingBloc>().add(InitializedDisplayAdvertising());
    
    // Fetches user account information if logged in.
    context.read<AuthAccountBloc>().add(DisplayInformationEvent());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      theme: ThemeData(
        scaffoldBackgroundColor: CustomColor.white,
        appBarTheme: AppBarTheme(
          backgroundColor: CustomColor.white,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: CustomColor.white,
            fontSize: 18,
            fontFamily: 'SN',
            fontWeight: FontWeight.w700,
          ),
          displayMedium: const TextStyle(
            fontFamily: 'SN',
            color: CustomColor.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          displaySmall: const TextStyle(
            fontFamily: 'SN',
            color: CustomColor.black,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            height: 2,
          ),
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
        // Ensures consistent text scaling across devices.
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
      // Determines the initial screen based on user login status.
      home: Authmanager().isLogin()
          ? BottomNavigationScreen()
          : const InitialScreen(),
    );
  }
}
