import 'dart:convert';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String base64;
  final double? height;

  const ImageCard({super.key, required this.base64, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.all(12),
      child: Card(
        child: Image.memory(
          base64Decode(base64),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}