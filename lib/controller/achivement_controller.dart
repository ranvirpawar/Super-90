import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super90/data/model/dailydata_model.dart';

class DopamineController extends GetxController {
  var workout = false.obs;
  var healthyDiet = false.obs;
  var reading = false.obs;
  final String currentDate;

  DopamineController(this.currentDate);

  @override
  void onInit() {
    super.onInit();
    _loadAchievements();
    printAllPreferences();
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

  Future<void> printAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (String key in keys) {
      print('$key: ${prefs.get(key)}');
    }
  }

  Future<Map<DateTime, bool>> getWorkoutData() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    Map<DateTime, bool> workoutDates = {};

    for (String key in keys) {
      if (_isValidDateFormat(key)) {
        try {
          final dailyDataStr = prefs.getString(key);
          if (dailyDataStr != null) {
            final dailyData = DailyData.fromJson(jsonDecode(dailyDataStr));
            final date = DateTime.parse(key);
            workoutDates[date] = dailyData.workout;
          }
        } catch (e) {
          print('Error parsing key $key: $e');
        }
      } else {
        print('Invalid date format for key: $key');
      }
    }
    return workoutDates;
  }

  bool _isValidDateFormat(String dateString) {
    try {
      DateTime.parse(dateString);
      return true;
    } catch (e) {
      return false;
    }
  }
}
