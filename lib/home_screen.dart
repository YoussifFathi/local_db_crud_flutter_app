import 'package:flutter/material.dart';
import 'package:local_db_app/database_manager.dart';
import 'package:local_db_app/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseManager databaseManager = DatabaseManager.instance;

  List<TaskModel> tasks = [];

  void initTaska() async {
    tasks = await databaseManager.fetchAllTasks();
    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTaska();
  }

  @override
  Widget build(BuildContext context) {
    Widget addNewTaskButton() {
      TextEditingController textEditingController = TextEditingController();
      return FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add New Task"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Task Name"),
                      controller: textEditingController,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await databaseManager
                              .addTask(textEditingController.text);
                          tasks = await databaseManager.fetchAllTasks();

                          setState(() {});
                        },
                        child: Text("Add"))
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      );
    }

    return Scaffold(
      floatingActionButton: addNewTaskButton(),
      body: SafeArea(
          child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
              await databaseManager.toggleTask(
                  tasks[index].id, !tasks[index].isFinished);
              tasks = await databaseManager.fetchAllTasks();
              setState(() {});
            },
            onLongPress: () async {
              await databaseManager.deleteTask(tasks[index].id);
              tasks = await databaseManager.fetchAllTasks();

              setState(() {});
            },
            title: Text(tasks[index].taskName),
            trailing: tasks[index].isFinished ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
            leading: IconButton(
                onPressed: () {
                  print("edit");
                },
                icon: Icon(Icons.edit)),
          );
        },
      )),
    );
  }
}
