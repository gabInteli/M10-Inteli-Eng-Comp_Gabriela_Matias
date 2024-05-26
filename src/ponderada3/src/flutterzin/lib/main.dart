import 'package:flutter/material.dart';
import 'package:flutterzin/login_page.dart';
import 'package:flutterzin/cadastro_page.dart'; // Adicione este import
import 'package:flutterzin/open_camera.dart'; // Adicione este import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
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
      routes: {
        '/cadastro_page': (context) => CadastroPage(), // Adicione esta rota
        '/login_page': (context) => LoginPage(),
        '/open_camera': (context) => OpenCameraPage(), // Adicione esta rotas
      },
    );
  }
}

class MinhaPrimeiraTela extends StatelessWidget {
  const MinhaPrimeiraTela({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'App da Gabi',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromARGB(255, 207, 206, 206)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  //importar a imagem 'logo.png' da minha pasta de assets
                  "assets/Gabriela.png", // "assets/logo.png",
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroPage()),
                  );
                },
                child: const Text('Cadastro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
