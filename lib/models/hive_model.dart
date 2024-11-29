class TaskModel {
  String task;
  DateTime time;
  bool check;

  TaskModel({
    required this.task,
    required this.time,
    required this.check,
  });

  Map toMap() {
    return {
      "task": task,
      "time": time,
      "check": check,
    };
  }

  factory TaskModel.fromMap(Map todo) {
    return TaskModel(
      task: todo["task"],
      time: todo["time"],
      check: todo["check"],
    );
  }
}