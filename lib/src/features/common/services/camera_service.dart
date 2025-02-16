import 'package:image_picker/image_picker.dart';
import 'package:mobile_frontend/src/domain/domain.dart';

class CameraService extends ICameraService {
  final _picker = ImagePicker();
  
  @override
  Future<String?> selectPhoto() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if(file == null) return null;

    return file.path;
  }
  
  @override
  Future<String?> takePhoto() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.camera);
    if(file == null) return null;

    return file.path;
  }
  
}
