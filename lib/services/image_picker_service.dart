import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final picker = ImagePicker();

  Future<List<XFile>> pickImages() async {
    return await picker.pickMultiImage();
  }
}