import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MinhaSegundaTela extends StatefulWidget {
  const MinhaSegundaTela({super.key});

  @override
  State<MinhaSegundaTela> createState() => _MinhaSegundaTelaState();
}

class _MinhaSegundaTelaState extends State<MinhaSegundaTela> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    String username = "gabriela";
    String password = "gabi";
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    var url = Uri.parse('http://172.21.208.1:5000/tasks');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': basicAuth,
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      setState(() {
        _tasks = json.decode(response.body);
      });
    }
  }

  Future<void> editTask(String taskId, String newTitle) async {
    String username = "gabriela";
    String password = "gabi";
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    var url = Uri.parse('http://172.21.208.1:5000/tasks/$taskId');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': basicAuth,
    };
    var response = await http.put(
      url,
      headers: headers,
      body: json.encode({'title': newTitle}),
    );
    if (response.statusCode == 200) {
      fetchTasks(); // Refresh tasks after editing
    }
  }

  void showEditDialog(String taskId, String currentTitle) {
    TextEditingController editController = TextEditingController(text: currentTitle);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Task"),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(hintText: "Enter new task title"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                editTask(taskId, editController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteTask(String taskId) async {
    String username = "gabriela";
    String password = "gabi";
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    var url = Uri.parse('http://172.21.208.1:5000/tasks/$taskId');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': basicAuth,
    };
    var response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      fetchTasks(); // Refresh tasks after deletion
    }
  }

  Future<void> addTask() async {
    String username = "gabriela";
    String password = "gabi";
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    var url = Uri.parse('http://172.21.208.1:5000/tasks');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': basicAuth,
    };
    String jsonBody = json.encode({
      'title': _controller.text,
    });
    var response = await http.post(
      url,
      headers: headers,
      body: jsonBody,
    );
    if (response.statusCode == 201) { // Verifica se a resposta é 201 Created
      fetchTasks();
    } else {
      // Trate erros, por exemplo, exibindo uma mensagem ao usuário
      print("Falha ao adicionar tarefa: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha segunda tela'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite sua tarefa',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await addTask();
            },
            child: const Text("Salvar"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tasks[index]['title']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showEditDialog(_tasks[index]['id'].toString(), _tasks[index]['title']);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteTask(_tasks[index]['id'].toString());
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
