import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class OpenCameraPage extends StatefulWidget {
  const OpenCameraPage({Key? key});

  @override
  _OpenCameraPageState createState() => _OpenCameraPageState();
}

class _OpenCameraPageState extends State<OpenCameraPage> {
  CameraController? _controller;
  late List<CameraDescription> cameras;
  bool _isPermissionGranted = false;
  List<String> imagePaths = [];

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      setState(() {
        _isPermissionGranted = true;
      });
      _initializeCamera();
    } else {
      setState(() {
        _isPermissionGranted = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Camera permission not granted'),
      ));
    }
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _controller = CameraController(cameras[0], ResolutionPreset.high);
      await _controller?.initialize();
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No cameras available'),
      ));
    }
  }

  Future<void> _takePicture() async {
    if (!_isPermissionGranted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Camera permission not granted'),
      ));
      return;
    }

    try {
      final directory = await getApplicationDocumentsDirectory();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String imagePath = '${directory.path}/$timestamp.jpg';

      if (_controller != null && _controller!.value.isInitialized) {
        final XFile file = await _controller!.takePicture();
        final File savedImage = File(file.path);
        await savedImage.copy(imagePath);
        setState(() {
          imagePaths.add(imagePath);
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Picture saved to $imagePath'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error taking picture: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Example'),
      ),
      body: Column(
        children: [
          _controller != null && _controller!.value.isInitialized
              ? Expanded(
                  flex: 8,
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: CameraPreview(_controller!),
                  ),
                )
              : const CircularProgressIndicator(),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _takePicture,
                  icon: Icon(Icons.camera),
                ),
                IconButton(
                  onPressed: () {
                  Navigator.pushNamed(context, '/gallery_page');
                },
                  icon: Icon(Icons.photo_library),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
