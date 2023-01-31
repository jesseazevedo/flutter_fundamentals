import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/dash.png', 3, color: Colors.black),
    Task('Andar de bike', 'assets/images/bike.webp', 2, color: Colors.black),
    Task('Meditar', 'assets/images/meditar.jpeg', 5, color: Colors.black),
    Task('Ler', 'assets/images/livro.jpg', 4, color: Colors.black),
    Task('Jogar', 'assets/images/jogar.jpg', 2, color: Colors.black),
  ];
  
  void newTask(String name, String photo, int difficulty) {
    taskList.add(Task(name, photo, difficulty, color: Colors.black,));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length != taskList.length;
  }
}
