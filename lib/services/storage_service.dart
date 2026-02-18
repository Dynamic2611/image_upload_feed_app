import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageService {
  Future<String> convertToBase64(String path) async {
    final bytes = await File(path).readAsBytes();
    return base64Encode(bytes);
  }

  Future<void> saveBase64(String base64) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/images.txt");
    await file.writeAsString("$base64\n", mode: FileMode.append);
  }
}