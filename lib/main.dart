import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/DataFuture/NetworkUtil/di.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_bloc.dart';
import 'package:aviz_project/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screen/add_advertising_screen.dart';
import 'widgets/buttomnavigationbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getInInit();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageNumberBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(
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