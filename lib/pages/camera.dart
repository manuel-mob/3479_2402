import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({required this.camera});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  List<String> _savedImages = [];

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
    _loadSavedImages(); // Load saved images on init
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      if (!mounted) return;

      // Save the picture to a specific directory
      final savedImagePath = await _savePicture(image);

      // Add the saved image path to the list and save it to shared preferences
      setState(() {
        _savedImages.add(savedImagePath);
      });
      _saveImagePaths();

      // Navigate to the DisplayPictureScreen to display the taken picture.
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(imagePath: savedImagePath),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<String> _savePicture(XFile image) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    final imageFile = File(image.path);
    final savedImage = await imageFile.copy(imagePath);
    return savedImage.path;
  }

  Future<void> _saveImagePaths() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('saved_images', _savedImages);
  }

  Future<void> _loadSavedImages() async {
    final prefs = await SharedPreferences.getInstance();
    final savedImages = prefs.getStringList('saved_images') ?? [];
    setState(() {
      _savedImages = savedImages;
    });
  }

  void _viewGallery() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GalleryScreen(imagePaths: _savedImages),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take a picture'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_library),
            onPressed: _viewGallery,
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}

// A widget that displays a grid of all saved pictures.
class GalleryScreen extends StatelessWidget {
  final List<String> imagePaths;

  const GalleryScreen({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Image.file(File(imagePaths[index]));
        },
      ),
    );
  }
}