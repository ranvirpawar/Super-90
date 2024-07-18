import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super90/components/horizontal_calender.dart';
import 'package:super90/constants/app_strings.dart';
import 'package:super90/controller/achivement_controller.dart';
import 'package:super90/controller/countdown_controller.dart';
import 'package:super90/controller/homescreen_controller.dart';
import 'package:super90/controller/task_controller.dart';
import 'package:super90/data/model/task_model.dart';
import 'package:super90/view/achivements.dart';

class HomeScreen extends StatelessWidget {
  final CountdownController countdownController =
      Get.put(CountdownController());

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now().toIso8601String().split('T')[0];
    final TaskController taskController = Get.put(TaskController(currentDate));
    final DopamineController achievementController =
        Get.put(DopamineController(currentDate));
    final HomeScreenController homeScreenController =
        Get.put(HomeScreenController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            'Day ${countdownController.daysPassed} / 90',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HorizontalCalendar(
                onSelected: (selectedDate) {
                  // Update controllers with the selected date
                  final formattedDate =
                      selectedDate.toIso8601String().split('T')[0];
                },
              ),
              SizedBox(height: 20),
              const Text(AppString.dopamineText,
                  style: TextStyle(fontSize: 20)),
              Wrap(
                spacing: 1,
                runSpacing: 0.5,
                children: [
                  Obx(
                    () => DopamineChips(
                        achievementController: achievementController,
                        title: 'Workout',
                        isSelected: achievementController.workout.value),
                  ),
                  Obx(
                    () => DopamineChips(
                        title: 'Healthy Diet',
                        achievementController: achievementController,
                        isSelected: achievementController.healthyDiet.value),
                  ),
                  Obx(
                    () => DopamineChips(
                        title: 'Reading',
                        achievementController: achievementController,
                        isSelected: achievementController.reading.value),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Card(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'How was your day?',
                  ),
                  onChanged: (text) {
                    homeScreenController.saveDailyNote(currentDate, text);
                  },
                ),
              ),
              SizedBox(height: 20),
              const Text(
                AppString.todaysChallenges,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
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
                child: Obx(
                  () => ListView.builder(
                    itemCount: taskController.tasks.length,
                    itemBuilder: (context, index) {
                      final task = taskController.tasks[index];
                      return _buildTaskTile(task, taskController, context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskTile(
      Task task, TaskController controller, BuildContext context) {
    TextEditingController editingController =
        TextEditingController(text: task.title);
    bool isEditing = false;

    return ListTile(
      title: isEditing
          ? TextField(
              controller: editingController,
              onSubmitted: (newValue) {
                controller.editTask(task, newValue);
                isEditing = false; // Reset editing mode
              },
            )
          : Text(task.title),
      onTap: () {
        // Toggle editing mode
        isEditing = !isEditing;
        if (isEditing) {
          editingController.text =
              task.title; // Initialize text field with task title
        } else {
          controller.editTask(
              task, editingController.text); // Save changes on tap away
        }
      },
      leading: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          // Toggle editing mode directly
          isEditing = !isEditing;
          if (isEditing) {
            editingController.text =
                task.title; // Initialize text field with task title
          }
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              controller.deleteTask(task);
            },
          ),
          Checkbox(
            value: task.isDone,
            onChanged: (bool? value) {
              controller.toggleTaskStatus(controller.tasks.indexOf(task));
            },
          ),
        ],
      ),
    );
  }
}

class DopamineChips extends StatelessWidget {
  const DopamineChips({
    super.key,
    required this.achievementController,
    required this.title,
    required this.isSelected,
  });
  final String title;
  final DopamineController achievementController;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChoiceChip(
        label: Text(title),
        selected: isSelected,
        onSelected: (bool selected) {
          if (title == 'Workout') {
            achievementController.toggleWorkout();
          } else if (title == 'Healthy Diet') {
            achievementController.toggleHealthyDiet();
          } else if (title == 'Reading') {
            achievementController.toggleReading();
          }
        },
      ),
    );
  }
}
