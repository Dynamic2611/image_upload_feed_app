import 'package:flutter/material.dart';
import '../widgets/image_card.dart';

class FixedFeedScreen extends StatelessWidget {
  final List<String> images;

  const FixedFeedScreen({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height * 0.7;

    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (_, i) => ImageCard(path: images[i], height: h),
    );
  }
}