import 'package:flutter/material.dart';
import '../services/image_picker_service.dart';
import '../services/storage_service.dart';
import '../services/upload_service.dart';
import 'fixed_feed_screen.dart';
import 'dynamic_feed_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final picker = ImagePickerService();
  final storage = StorageService();
  final uploader = UploadService();

  List<String> imagePaths = [];

  Future<void> pickImages() async {
    final files = await picker.pickImages();

    for (var file in files) {
      final base64 = await storage.convertToBase64(file.path);
      await storage.saveBase64(base64);
      imagePaths.add(file.path);
    }

    await uploader.uploadSequentially(imagePaths);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Image Feed App"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Upload"),
              Tab(text: "Fixed Feed"),
              Tab(text: "Dynamic Feed"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: pickImages,
          child: const Icon(Icons.add),
        ),
        body: TabBarView(
          children: [
            const Center(child: Text("Tap + to upload images")),
            FixedFeedScreen(images: imagePaths),
            DynamicFeedScreen(images: imagePaths),
          ],
        ),
      ),
    );
  }
}