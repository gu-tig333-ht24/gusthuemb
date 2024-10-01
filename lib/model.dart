class Task {
  String? id;
  String task;
  bool ischecked;

  Task(this.task, this.ischecked, [this.id]);

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(json['title'], json['done'], json['id']);
  }
  Map<String, dynamic> toJson() {
    return {
      "title": task,
      "done": ischecked,
    };
  }
}

