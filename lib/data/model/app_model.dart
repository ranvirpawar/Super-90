class Countdown {
  DateTime targetDate;

  Countdown({required this.targetDate});

  int get daysLeft {
    return targetDate.difference(DateTime.now()).inDays;
  }
}
class Achievement {
  bool workout;
  bool healthyDiet;
  bool reading;

  Achievement({this.workout = false, this.healthyDiet = false, this.reading = false});
}
class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});

  // Convert a Task object into a Map object
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }

  // Convert a Map object into a Task object
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isDone: json['isDone'],
    );
  }
}


