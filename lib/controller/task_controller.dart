import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super90/data/model/app_model.dart';

import 'package:super90/data/model/dailydata_model.dart';


class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  final String currentDate;

  TaskController(this.currentDate);

  @override
  void onInit() {
    super.onInit();
    _loadTasks();
  }

  void addTask(String title) {
    tasks.add(Task(title: title));
    tasks.refresh();
    _saveTasks();
  }

  void toggleTaskStatus(int index) {
    tasks[index].isDone = !tasks[index].isDone;
    tasks.refresh();
    _saveTasks();
  }

  void _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final dailyData = DailyData(
      tasks: tasks,
      workout: false,
      healthyDiet: false,
      reading: false,
      note: '',
    );
    prefs.setString(currentDate, jsonEncode(dailyData.toJson()));
  }

  void _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final dailyDataStr = prefs.getString(currentDate);
    if (dailyDataStr != null) {
      final dailyData = DailyData.fromJson(jsonDecode(dailyDataStr));
      tasks.assignAll(dailyData.tasks);
    }
  }
}
