import 'package:flutter/material.dart';
import 'package:todo/constant/colors.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/screen/add_task.dart';

class todolist extends StatelessWidget {
  final ToDo todo;

  final onToDoChenged;
  final onDeletedItem;
  final onEditItem;
  const todolist(
      {super.key,
      required this.todo,
      required this.onDeletedItem,
      required this.onToDoChenged,
      required this.onEditItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChenged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tbBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 20,
              color: tbBlack,
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        subtitle: Text(todo.date!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: tbBlue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                onPressed: () {
                  onEditItem(todo);
                },
                iconSize: 18,
                icon: Icon(Icons.edit),
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: tbRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                onPressed: () {
                  onDeletedItem(todo.id);
                },
                iconSize: 18,
                icon: Icon(Icons.delete),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
