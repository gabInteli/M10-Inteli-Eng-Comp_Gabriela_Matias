import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutterzin/login_page.dart';
import 'package:flutterzin/cadastro_page.dart';
import 'package:flutterzin/open_camera.dart';
import 'package:flutterzin/gallery_page.dart'; // Adicione esta importação
import 'package:permission_handler/permission_handler.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    // Solicita permissão de notificações
    _requestNotificationPermission();

    // Inicializa o plugin de notificações locais
    _initializeLocalNotifications();

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
        '/cadastro_page': (context) => CadastroPage(),
        '/login_page': (context) => LoginPage(),
        '/open_camera': (context) => OpenCameraPage(),
        '/gallery_page': (context) => GalleryPage(
            flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin),
      },
    );
  }

  Future<void> _requestNotificationPermission() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status != PermissionStatus.granted) {
      // Se a permissão não foi concedida, você pode lidar com isso aqui
      // Por exemplo, mostrando um diálogo informando ao usuário que as notificações não estarão disponíveis
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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
                  "assets/Gabriela.png",
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login_page');
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cadastro_page');
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
