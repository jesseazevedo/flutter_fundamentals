import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/taskDAO.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;
  int nivel;
  Color? color = Colors.black;

  Task(this.nome, this.foto, this.dificuldade, this.nivel, {Key? key, this.color})
      : super(key: key);

  @override
  State<Task> createState() => _TaskState();

  colorChange(double nvl) {
    if (nvl <= 0.2) {
      color = Colors.black;
    } else if (nvl <= 0.4) {
      color = Colors.redAccent;
    } else if (nvl <= 0.6) {
      color = Colors.orange;
    } else if (nvl <= 0.8) {
      color = Colors.cyan;
    } else if (nvl < 1) {
      color = Colors.blue;
    } else {
      color = Colors.green;
    }
  }
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: widget.color,
            ),
            height: 140,
          ),
          Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black26,
                        ),
                        width: 72,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: assetOrNetwork()
                              ? Image.asset(
                                  widget.foto,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.foto,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 200,
                              child: Text(
                                widget.nome,
                                style: const TextStyle(
                                    fontSize: 24,
                                    overflow: TextOverflow.ellipsis),
                              )),
                          Difficulty(dificultyLevel: widget.dificuldade)
                        ],
                      ),
                      SizedBox(
                        height: 52,
                        width: 52,
                        child: ElevatedButton(
                            onLongPress: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text(
                                          'Você deseja excluir essa tarefa?'),
                                      content: const Text(
                                          'Você está prestes a excluir essa tarefa de sua lista. Deseja remove-la?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              context, 'Cancelar'),
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            TaskDao().delete(widget.nome);
                                            Navigator.pop(context, 'Sim');
                                          },
                                          child: const Text('Sim'),
                                        ),
                                      ],
                                    )),
                            onPressed: () {
                              setState(() {
                                widget.nivel++;
                                widget.colorChange((widget.dificuldade > 0)
                                    ? (widget.nivel / widget.dificuldade) / 10
                                    : 1);
                                TaskDao().save(widget);
                              });
                              // print(widget.nivel);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Icon(Icons.arrow_drop_up),
                                Text(
                                  'UP',
                                  style: (TextStyle(fontSize: 12)),
                                ),
                              ],
                            )),
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.dificuldade > 0)
                            ? (widget.nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Nivel: ${widget.nivel}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
