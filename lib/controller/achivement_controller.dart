import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super90/data/model/dailydata_model.dart';

class AchievementController extends GetxController {
  var workout = false.obs;
  var healthyDiet = false.obs;
  var reading = false.obs;
  final String currentDate;

  AchievementController(this.currentDate);

  @override
  void onInit() {
    super.onInit();
    _loadAchievements();
  }

  void toggleWorkout() {
    workout.value = !workout.value;
    _saveAchievements();
  }

  void toggleHealthyDiet() {
    healthyDiet.value = !healthyDiet.value;
    _saveAchievements();
  }

  void toggleReading() {
    reading.value = !reading.value;
    _saveAchievements();
  }

  void _saveAchievements() async {
    final prefs = await SharedPreferences.getInstance();
    final dailyDataStr = prefs.getString(currentDate);
    if (dailyDataStr != null) {
      final dailyData = DailyData.fromJson(jsonDecode(dailyDataStr));
      dailyData.workout = workout.value;
      dailyData.healthyDiet = healthyDiet.value;
      dailyData.reading = reading.value;
      prefs.setString(currentDate, jsonEncode(dailyData.toJson()));
    }
  }

  void _loadAchievements() async {
    final prefs = await SharedPreferences.getInstance();
    final dailyDataStr = prefs.getString(currentDate);
    if (dailyDataStr != null) {
      final dailyData = DailyData.fromJson(jsonDecode(dailyDataStr));
      workout.value = dailyData.workout;
      healthyDiet.value = dailyData.healthyDiet;
      reading.value = dailyData.reading;
    }
  }
}
