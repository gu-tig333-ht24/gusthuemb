class Task {
  String? id;
  String task;
  bool isChecked;

  Task(this.task, this.isChecked, [this.id]);

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(json['title'], json['done'], json['id']);
  }
  Map<String, dynamic> toJson() {
    return {
      "title": task,
      "done": isChecked,
    };
  }
}

