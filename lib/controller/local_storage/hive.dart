import 'package:hive_flutter/adapters.dart';

class HiveHelper {
  static late Box box;
  // static var box;
  static Future<void> hiveInit() async {
    await Hive.initFlutter();
  }

  // static String? boxName;
  static Future<void> openBox({String? nameBox}) async {
    box = await Hive.openBox(nameBox!);
  }

  static Future<void> setData({
    String? key,
    String? value,
  }) async {
    box.put(key, value);
  }

  static String? getData({
    String? key,
  }) {
    return box.get(key);
  }
}
