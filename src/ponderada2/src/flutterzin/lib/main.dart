import 'package:flutter/material.dart';
import 'package:flutterzin/segunda_tela.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      home: const MinhaPrimeiraTela(),
    );
  }
}

class MinhaPrimeiraTela extends StatelessWidget {
  const MinhaPrimeiraTela({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Lista de Tarefas',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255), // Lilás claro para o fundo
        child: Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/Gabriela.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Bem vindo! Clique no botão abaixo para acessar suas tarefas!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MinhaSegundaTela()),
                      );
                    },
                    child: const Text('Acesse aqui'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
