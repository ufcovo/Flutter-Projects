// ignore_for_file: prefer_initializing_formals

class ToDo {
  int? id;
  int? userId;
  bool? completed;
  String? title;

  ToDo(int id, int userId, bool completed, String title) {
    this.id = id;
    this.userId = userId;
    this.completed = completed;
    this.title = title;
  }

  ToDo.fromJson(Map json) {
    id = json['id'];
    userId = json["userId"];
    completed = json["completed"];
    title = json["title"];
  }

  Map toJson() {
    return {"id": id, "userId": userId, "completed": completed, "title": title};
  }
}
