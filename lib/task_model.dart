
class TaskModel {
  final String taskName;
  bool isFinished;
  final int id;

  TaskModel(
      {required this.taskName, required this.isFinished, required this.id});

  factory TaskModel.fromJson(data) {
    return TaskModel(
      taskName: data["name"],
      isFinished: data["isFinished"] == 1 ? true : false,
      id: data["id"],
    );
  }
}
