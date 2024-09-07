class ToDo {
  String? id;
  String? todoText;
  String? date;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    required this.date,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [];
  }
}
