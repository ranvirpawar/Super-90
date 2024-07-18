import 'package:super90/data/model/app_model.dart';
import 'package:super90/data/model/task_model.dart';

class DailyData {
  List<Task> tasks;
  bool workout;
  bool healthyDiet;
  bool reading;
  String note;

  DailyData({
    required this.tasks,
    this.workout = false,
    this.healthyDiet = false,
    this.reading = false,
    this.note = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'tasks': tasks.map((task) => task.toJson()).toList(),
      'workout': workout,
      'healthyDiet': healthyDiet,
      'reading': reading,
      'note': note,
    };
  }

  factory DailyData.fromJson(Map<String, dynamic> json) {
    return DailyData(
      tasks: (json['tasks'] as List)
          .map((taskJson) => Task.fromJson(taskJson))
          .toList(),
      workout: json['workout'],
      healthyDiet: json['healthyDiet'],
      reading: json['reading'],
      note: json['note'],
    );
  }
}
