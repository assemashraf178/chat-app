import 'package:bloc/bloc.dart';
import 'package:chat_app/shared/BlocObserver.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:chat_app/shared/network/local/cashed_helper.dart';
import 'package:chat_app/shared/network/remote/dio_helper.dart';
import 'package:chat_app/shared/styles/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_cubit/cubit.dart';
import 'app_cubit/states.dart';
import 'layouts/home_layout.dart';
import 'modules/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CashedHelper.init();
  DioHelper.init();
  uId = CashedHelper.getData(key: 'uId');
  print(uId);
  late Widget startWidget;
  if (uId == null) {
    startWidget = LoginScreen();
  } else {
    startWidget = HomeLayout();
  }
  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getUsers()
        ..getChats(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Home',
            theme: lightMode(),
            darkTheme: darkMode(),
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
