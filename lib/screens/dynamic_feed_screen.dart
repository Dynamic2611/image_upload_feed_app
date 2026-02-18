import 'package:flutter/material.dart';
import '../widgets/image_card.dart';

class DynamicFeedScreen extends StatelessWidget {
  final List<String> images;

  const DynamicFeedScreen({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (_, i) => ImageCard(base64: images[i]),
    );
  }
}