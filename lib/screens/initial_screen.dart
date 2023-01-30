import 'package:flutter/material.dart';

import '../components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Tarefas'),
      ),
      body: AnimatedOpacity(
        opacity: (opacidade == true) ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        child: ListView(
          children: [
            Task(
                'Aprender Flutter no café da manhã comendo sucrilhos',
                'assets/images/dash.png',
                3, color: Colors.black),
            Task(
                'Andar de bike',
                'assets/images/bike.webp',
                2, color: Colors.black),
            Task(
                'Meditar',
                'assets/images/meditar.jpeg',
                5, color: Colors.black),
            Task(
                'Ler',
                'assets/images/livro.jpg',
                4, color: Colors.black),
            Task(
                'Jogar',
                'assets/images/jogar.jpg',
                2, color: Colors.black),
            SizedBox(height: 80,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacidade = !opacidade;
          });
        },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}