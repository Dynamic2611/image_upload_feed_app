class UploadService {
  Future<void> uploadSequentially(List<String> paths) async {
    for (int i = 0; i < paths.length; i++) {
      await Future.delayed(const Duration(seconds: 1));
      print("Uploaded ${paths[i]}");
    }
  }
}