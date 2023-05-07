// ignore_for_file: unused_local_variable, avoid_print

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:telegram/components/const.dart';
import 'package:telegram/controller/local_storage/hive.dart';
import 'package:telegram/state_management/cubit_states.dart';
import 'package:telegram/state_management/home_cubit.dart';
import 'package:telegram/test.dart';
import 'package:telegram/view/Setting_view.dart';
import 'package:telegram/view/home_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:telegram/view/register_view.dart';

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
    firstScreen = RegisterView();
  }
  runApp(
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
    return BlocProvider(
      create: (context) => HomeCubit()..getAllUser(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  useInheritedMediaQuery: true,
                  locale: DevicePreview.locale(context),
                  builder: DevicePreview.appBuilder,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    // is not restarted.
                    primarySwatch: Colors.blue,
                  ),
                  home: widget
                  // SettingView()
                  // TestView(),
                  // RegisterView()
                  );
            },
          );
        },
      ),
    );
  }
}
