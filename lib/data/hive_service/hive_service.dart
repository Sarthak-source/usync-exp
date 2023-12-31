import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HiveService {
  isExists({String? boxName}) async {
    final openBox = await Hive.openBox(boxName ?? '');
    int length = openBox.length;
    return length != 0;
  }

  addBoxItem<T>(T items, String boxName) async {
    debugPrint("adding box");
    final openBox = await Hive.openBox(boxName);

    openBox.put(boxName, items);
  }

  getBoxItem<T>(String boxName) async {
    final openBox = await Hive.openBox(boxName);

    return openBox.get(boxName) as T;
  }

  addBoxes<T>(List<T> items, String boxName) async {
    debugPrint("adding boxes");
    final openBox = await Hive.openBox(boxName);

    for (var item in items) {
      openBox.add(item);
    }
  }

  getBoxes<T>(String boxName) async {
    List<T> boxList = <T>[];

    final openBox = await Hive.openBox(boxName);

    int length = openBox.length;

    for (int i = 0; i < length; i++) {
      boxList.add(openBox.getAt(i));
    }

    return boxList;
  }
}
