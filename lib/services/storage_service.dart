import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageService {

  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/images.json");
  }

  Future<void> saveImage(String base64) async {
    final file = await _file();

    List list = [];

    if (await file.exists()) {
      list = jsonDecode(await file.readAsString());
    }

    list.add(base64);

    await file.writeAsString(jsonEncode(list));
  }

  Future<List<String>> loadImages() async {
    final file = await _file();

    if (!await file.exists()) return [];

    List list = jsonDecode(await file.readAsString());

    return List<String>.from(list);
  }
}