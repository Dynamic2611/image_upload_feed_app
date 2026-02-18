import 'dart:io';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String path;
  final double? height;

  const ImageCard({super.key, required this.path, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.all(12),
      child: Card(
        child: Image.file(
          File(path),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}