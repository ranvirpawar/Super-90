import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super90/controller/achivement_controller.dart';
import 'package:super90/controller/countdown_controller.dart';
import 'package:super90/controller/homescreen_controller.dart';
import 'package:super90/controller/task_controller.dart';
import 'package:super90/data/model/dailydata_model.dart';

class HomeScreen extends StatelessWidget {
  final CountdownController countdownController =
      Get.put(CountdownController());

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now().toIso8601String().split('T')[0];
    final TaskController taskController = Get.put(TaskController(currentDate));
    final AchievementController achievementController =
        Get.put(AchievementController(currentDate));
    final HomeScreenController homeScreenController =
        Get.put(HomeScreenController());

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() => Text(
                  'Day ${countdownController.daysPassed} / 90',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
            SizedBox(height: 20),
            Text('Today\'s To-Do List', style: TextStyle(fontSize: 20)),
            TextField(
              decoration: InputDecoration(
                labelText: 'Add a task',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  taskController.addTask(value);
                }
              },
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: taskController.tasks.length,
                    itemBuilder: (context, index) {
                      final task = taskController.tasks[index];
                      return CheckboxListTile(
                        title: Text(task.title),
                        value: task.isDone,
                        onChanged: (bool? value) {
                          taskController.toggleTaskStatus(index);
                        },
                      );
                    },
                  )),
            ),
            SizedBox(height: 20),
            Text('Achievements', style: TextStyle(fontSize: 20)),
            Obx(() => CheckboxListTile(
                  title: Text('Workout?'),
                  value: achievementController.workout.value,
                  onChanged: (bool? value) {
                    achievementController.toggleWorkout();
                  },
                )),
            Obx(() => CheckboxListTile(
                  title: Text('Healthy Diet?'),
                  value: achievementController.healthyDiet.value,
                  onChanged: (bool? value) {
                    achievementController.toggleHealthyDiet();
                  },
                )),
            Obx(() => CheckboxListTile(
                  title: Text('Reading?'),
                  value: achievementController.reading.value,
                  onChanged: (bool? value) {
                    achievementController.toggleReading();
                  },
                )),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'How was your day?',
              ),
              maxLines: 3,
              onChanged: (text) {
                homeScreenController.saveDailyNote(currentDate, text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
