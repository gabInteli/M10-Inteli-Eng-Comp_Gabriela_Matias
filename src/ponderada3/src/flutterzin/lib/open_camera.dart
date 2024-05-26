import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class OpenCameraPage extends StatefulWidget {
  @override
  _OpenCameraPageState createState() => _OpenCameraPageState();
}

class _OpenCameraPageState extends State<OpenCameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final CameraDescription? camera = await _getCamera();

    if (camera == null) {
      // Tratamento de erro: Câmera não encontrada
      return;
    }

    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    try {
      _initializeControllerFuture = _controller.initialize();
    } catch (e) {
      // Tratamento de erro: Falha ao inicializar a câmera
      print('Erro ao inicializar a câmera: $e');
    }
  }

  Future<CameraDescription?> _getCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      // Tratamento de erro: Nenhuma câmera encontrada
      return null;
    }
    return cameras.first;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera App'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else if (snapshot.hasError) {
            // Tratamento de erro: Exibir mensagem de erro ao usuário
            return Center(
              child: Text(
                'Erro ao inicializar a câmera',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Gallery',
          ),
        ],
      ),
    );
  }
}
