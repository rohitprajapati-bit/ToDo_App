import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo/constant/colors.dart';
import 'package:todo/screen/add_task.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/model/todo_Ui.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todoList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tbBGColor,
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: tbBlue,
        onPressed: () async {
          final value = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
          if (value != null && value is ToDo) {
            print(value.id);
            todoList.add(value);
            setState(() {});
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            SearchBox(),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 20),
                    child: Text(
                      "All ToDos",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ),
                  for (ToDo todoo in _foundToDo.reversed)
                    todolist(
                      todo: todoo,
                      onToDoChenged: _handelToDoChenge,
                      onDeletedItem: _deletedToDoItem,
                      onEditItem: _editedToDoItem,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handelToDoChenge(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deletedToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _editedToDoItem(ToDo todo) async {
    final value = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddTask(
                  todo: todo,
                )));
    if (value != null && value is ToDo) {
      setState(() {
        todo.todoText = value.todoText;
        todo.date = value.date;
      });
    }
  }

  void _runfilter(String enterKeyWord) {
    List<ToDo> result = [];
    if (enterKeyWord.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where((item) =>
              item.todoText!.toLowerCase().contains(enterKeyWord.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = result;
    });
  }

  Widget SearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(50)),
      child: TextField(
        onChanged: (value) => _runfilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tbBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 25),
            border: InputBorder.none,
            hintText: 'Search'
            //  hintStyle:TextStyle (color:tbGray)

            ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tbBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tbBlack,
            size: 30,
          ),
          Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/image/rohit.png"),
              ))
        ],
      ),
    );
  }
}
