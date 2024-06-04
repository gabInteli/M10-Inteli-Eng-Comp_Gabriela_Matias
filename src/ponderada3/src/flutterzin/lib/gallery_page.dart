  import 'package:flutter/material.dart';
  import 'dart:io';
  import 'package:path_provider/path_provider.dart';
  import 'package:image/image.dart' as img;
  import 'package:flutter_local_notifications/flutter_local_notifications.dart';

  import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class GalleryPage extends StatefulWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin; // Adicione esta linha

  // Adicione este construtor
  const GalleryPage({Key? key, required this.flutterLocalNotificationsPlugin}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

  class _GalleryPageState extends State<GalleryPage> {
    List<File> images = [];
    List<File> processedImages = [];
    late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

    @override
    void initState() {
      super.initState();
      _loadImages();
      _initializeNotifications();
    }

    Future<void> _initializeNotifications() async {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      final InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    }

    Future<void> _showNotification(String filePath) async {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('your channel id', 'your channel name',
              channelDescription: 'your channel description',
              importance: Importance.max,
              priority: Priority.high,
              showWhen: false);
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0,
        'Imagem Processada',
        'Uma imagem foi processada com sucesso.',
        platformChannelSpecifics,
        payload: filePath,
      );
    }

    Future<void> _loadImages() async {
      final directory = await getApplicationDocumentsDirectory();
      final files = directory.listSync();

      setState(() {
        images = files
            .where((file) =>
                file.path.endsWith('.jpg') && !file.path.contains('_filtered.jpg'))
            .map((file) => File(file.path))
            .toList();
        processedImages = files
            .where((file) => file.path.endsWith('_filtered.jpg'))
            .map((file) => File(file.path))
            .toList();
      });
    }

    Future<void> _applyFilter(File imageFile) async {
      // Ler o arquivo da imagem
      List<int> imageBytes = await imageFile.readAsBytes();
      img.Image image = img.decodeImage(imageBytes)!;

      // Aplicar filtro (exemplo: converter para preto e branco)
      img.Image filteredImage = img.grayscale(image);

      // Salvar a imagem filtrada em um novo arquivo
      final filteredImageFile =
          File(imageFile.path.replaceAll('.jpg', '_filtered.jpg'));
      await filteredImageFile.writeAsBytes(img.encodeJpg(filteredImage));

      // Atualizar a lista de imagens processadas para refletir a imagem filtrada
      setState(() {
        processedImages.add(filteredImageFile);
      });

      // Enviar notificação
      _showNotification(filteredImageFile.path);
    }

    void _openImageFullScreen(File imageFile) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenImagePage(imageFile: imageFile),
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Gallery')),
        body: ListView(
          children: [
            // Card para a seção "Fotos"
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Fotos',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _openImageFullScreen(images[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.file(
                                    images[index],
                                    height: 100, // Definindo altura fixa para reduzir o tamanho da imagem
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _applyFilter(images[index]);
                                    },
                                    child: Text('Filter Apply'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Card para a seção "Imagens Processadas"
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Imagens Processadas',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: processedImages.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _openImageFullScreen(processedImages[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              child: Image.file(
                                processedImages[index],
                                height: 100, // Definindo altura fixa para reduzir o tamanho da imagem
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  class FullScreenImagePage extends StatelessWidget {
    final File imageFile;

    FullScreenImagePage({required this.imageFile});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Image.file(imageFile),
        ),
      );
    }
  }
