import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/constant/colors.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/screen/home_page.dart';

class AddTask extends StatefulWidget {
  final ToDo? todo;
  final ToDo? date;

  const AddTask({super.key, this.todo, this.date});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController _addTask = TextEditingController();

  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    dateinput.text = "";
    // TODO: implement initState
    super.initState();
    if (widget.todo != null) {
      _addTask.text = widget.todo!.todoText ?? '';
      dateinput.text = widget.todo!.date ?? '';
    }
  }

  @override
  void dispose() {
    dateinput.dispose();
    _addTask.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tbBGColor,
      appBar: AppBar(
        title: Text(
          "New Task",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: tbBGColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_addTask.text.trim().isNotEmpty) {
            ToDo checkButton = ToDo(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                todoText: _addTask.text,
                date: dateinput.text);

            Navigator.pop(
              context,
              checkButton,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Please Enter a Task"),
            ));
          }
        },
        child: Icon(Icons.check),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What is to be done?",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      controller: _addTask,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Task Here",
                      ),
                      maxLines: 4,
                    ),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Due date",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      controller: dateinput,
                      readOnly: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Date not set",
                          suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: currentDate,
                                  firstDate: DateTime(2023),
                                  lastDate: DateTime(2050));
      
                              if (pickedDate != null) {
                                final UserPickedDate = pickedDate;
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd')
                                        .format(UserPickedDate);
                                setState(() {
                                  dateinput.text = formattedDate;
                                });
                              }
                            },
                            icon: Icon(Icons.calendar_today),
                          )),
                    ),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void _addToDoItem(String toDo) {
//   setState(() {
//     todoList.add(ToDo(
//         id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
//   });
// }
