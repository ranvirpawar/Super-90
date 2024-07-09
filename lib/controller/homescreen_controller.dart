import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super90/data/model/dailydata_model.dart';

class HomeScreenController extends GetxController {
  void saveDailyNote(String date, String note) async {
    final prefs = await SharedPreferences.getInstance();
    final dailyDataStr = prefs.getString(date);
    if (dailyDataStr != null) {
      final dailyData = DailyData.fromJson(jsonDecode(dailyDataStr));
      dailyData.note = note;
      prefs.setString(date, jsonEncode(dailyData.toJson()));
    }
  }
  
}