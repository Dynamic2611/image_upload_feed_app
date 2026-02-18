
import 'dart:convert';
import 'dart:io';
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

  List<String> base64Images = [];

  @override
  void initState() {
    super.initState();
    loadSaved();
  }

  Future<void> loadSaved() async {
    base64Images = await storage.loadImages();
    setState(() {});
  }

  Future<void> pickImages() async {
    final files = await picker.pickImages();

    for (var file in files) {
    final bytes = await File(file.path).readAsBytes();
    final base64 = base64Encode(bytes);

    await storage.saveImage(base64);
      base64Images.add(base64);
    }

    await uploader.uploadSequentially(files.map((e) => e.path).toList());

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
          GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: base64Images.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            ),
            itemBuilder: (_, i) {
              return Image.memory(
                base64Decode(base64Images[i]),
                fit: BoxFit.cover,
              );
            },
          ),

          FixedFeedScreen(images: base64Images),

          DynamicFeedScreen(images: base64Images),
          ],
        ),
      ),
    );
  }
}

