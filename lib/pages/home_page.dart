import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasuku/models/hive_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _newTaskInput;
  Box? _box;
  late double _deviceHeight;
  late double _deviceWidth;
  _HomePageState();
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: _deviceHeight * 0.1,
          backgroundColor: Colors.black,
          title: Text(
            "TASUKU",
            style: TextStyle(letterSpacing: _deviceWidth * 0.05),
          ),
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w900,
          ),
        ),
        body: _getAllLists(),
        floatingActionButton: _addToList(),
      ),
    );
  }

  Widget _listOfTaskView() {
    List tasks = _box!.values.toList();
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext _context, int _index) {
          TaskModel task = TaskModel.fromMap(tasks[_index]);
          return ListTile(
            title: Text(
              task.task,
              style: TextStyle(
                  decoration: task.check ? TextDecoration.lineThrough : null,
                  fontSize: 27),
            ),
            subtitle: Text(
              "${task.time.day.toString()}/${task.time.month.toString()} - ${task.time.hour.toString()}:${task.time.minute.toString()}:${task.time.second.toString()}",
              style: const TextStyle(fontSize: 15),
            ),
            trailing: Icon(
              task.check ? Icons.check_box_outlined : Icons.check_box_outline_blank,
            ),
            onLongPress: () {
              _box?.deleteAt(_index);
              setState(() {});
            },
            onTap: () {
              task.check = !task.check;
              _box?.putAt(
                _index,
                task.toMap(),
              );
              setState(() {});
            },
          );
        });
  }

  Widget _getAllLists() {
    return FutureBuilder(
      future: Hive.openBox("lists"),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          _box = _snapshot.data;
          if (_box!.length <= 0) {
            return _showEmpty();
          } else {
            return _listOfTaskView();
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _showEmpty() {
    return Center(
      child: Icon(Icons.filter_list_off_outlined, size: _deviceWidth * 0.5, color: Colors.grey,),
    );
  }

  Widget _addToList() {
    return FloatingActionButton(
      onPressed: _popupModal,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      tooltip: "Add",
      child: const Icon(Icons.add),
    );
  }

  void _popupModal() {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            icon: const Icon(Icons.list_rounded),
            iconColor: Colors.black,
            content: TextField(
              autofocus: true,
              onSubmitted: (_value) {
                if (_newTaskInput != null) {
                  TaskModel newTasks = TaskModel(
                      task: _newTaskInput.toString(),
                      time: DateTime.now(),
                      check: false);
                  _box?.add(newTasks.toMap());
                  setState(() {
                    _newTaskInput = null;
                    Navigator.pop(context);
                  });
                }
              },
              onChanged: (_value) {
                setState(() {
                  _newTaskInput = _value;
                });
              },
            ),
          );
        });
  }
}
