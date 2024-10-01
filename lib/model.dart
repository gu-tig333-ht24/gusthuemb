class Todo {
  String? id;
  String task;
  bool ischecked;

  Todo(this.task, this.ischecked, [this.id]);

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(json['title'], json['done'], json['id']);
  }
  Map<String, dynamic> toJson() {
    return {
      "title": task,
      "done": ischecked,
    };
  }
}

