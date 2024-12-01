import 'package:photo_manager/photo_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadController {
  final ImagePicker _picker = ImagePicker();
  List<AssetEntity> _images = [];
  bool _isLoading = true;
  File? _image;

  List<AssetEntity> get images => _images;
  bool get isLoading => _isLoading;
  File? get image => _image;

  Future<void> loadPhotos() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      final albums =
          await PhotoManager.getAssetPathList(type: RequestType.image);
      if (albums.isNotEmpty) {
        final recentAlbum = albums.first;
        final recentPhotos =
            await recentAlbum.getAssetListRange(start: 0, end: 50);
        _images = recentPhotos;
        _isLoading = false;
      }
    } else {
      await PhotoManager.openSetting();
    }
  }

  Future<void> selectImage(AssetEntity asset) async {
    final file = await asset.file;
    if (file != null) {
      _image = file;
    }
  }

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  Future<bool> checkCameraPermission() async {
    final permission = await PhotoManager.requestPermissionExtend();
    return permission.isAuth;
  }
}
