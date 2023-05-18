// ignore_for_file: unused_local_variable, avoid_print

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/chatting/cubit/chatting_cubit.dart';
import 'package:telegram/chatting/widgets/custom_web_view.dart';
import 'package:telegram/components/const.dart';
import 'package:telegram/controller/local_storage/hive.dart';
import 'package:telegram/login/cubit/login_cubit.dart';
import 'package:telegram/register/cubit/register_cubit.dart';
import 'package:telegram/home/home_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:telegram/register/register_view.dart';
import 'package:telegram/user/cubit/user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HiveHelper.hiveInit();
  Directory dir = await getApplicationDocumentsDirectory();
  await HiveHelper.openBox(nameBox: "userData");

  MyConst.uidUser = HiveHelper.getData(key: "userToken");

  print("uidUser :  ${MyConst.uidUser}");
  Widget? firstScreen;
  if (MyConst.uidUser != null) {
    firstScreen = const HomeView();
  } else {
    firstScreen = const RegisterView();
  }
  runApp(
    // MyApp(widget: firstScreen)
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(widget: firstScreen), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.widget});
  final Widget? widget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubit(),
          ),
          BlocProvider(
            create: (context) => RegisterCubit(),
          ),
          // BlocListener(listener: (context, state) => HomevCubit()..getMessage(),),
          BlocProvider(
            create: (context) => UserCubit()..getAllUser(),
          ),
          BlocProvider(
            create: (context) => ChattingCubit()..getMessage(),
          ),
          // BlocProvider(create: (context) => HomeCubit(),),
        ],
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                // useInheritedMediaQuery: true,
                // routes: {
                // When navigating to the "/" route, build the FirstScreen widget.

                // When navigating to the "/second" route, build the SecondScreen widget.
                //   '/homeView': (context) => const HomeView(),
                // },
                locale: DevicePreview.locale(context),
                builder: DevicePreview.appBuilder,
                title: 'Flutter Demo',
                theme: ThemeData(
                  // is not restarted.
                  primarySwatch: Colors.blue,
                ),
                home:
                    // DisplayImage()
                    widget
                    // CustomWebView()
                // SettingView()
                // Test(),
                // RegisterView()
                );
          },
        ));
  }
}
