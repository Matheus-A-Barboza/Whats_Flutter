import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List task = [];
  TextEditingController controller = TextEditingController();

  messageAdd() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarefa Cadastrada com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  messageRmv() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarefa Removida com sucesso!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  messageBlock() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Não é possivel adicionar uma tarefa vazia!'),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To do List')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Tarefa',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: task.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () {
                      setState(() {
                        task.removeAt(index);
                      });
                      messageRmv();
                    },
                    title: Text(task[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.text == '') {
            messageBlock();
          } else {
            setState(() {
              task.add(controller.text);
              controller.clear();
            });
            messageAdd();
            print(task);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
