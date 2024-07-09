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
