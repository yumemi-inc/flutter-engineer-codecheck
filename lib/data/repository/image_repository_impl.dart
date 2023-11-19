import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_engineer_codecheck/data/repository/image_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_repository_impl.g.dart';

@riverpod
ImageRepositoryImpl imageRepository(ImageRepositoryRef ref) {
  return ImageRepositoryImpl();
}

class ImageRepositoryImpl extends ImageRepository {
  @override
  Future<String?> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }

    return image.path;
  }

  @override
  Future<String> saveImage(String imageUrl, String saveUrl) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child(saveUrl);

    final file = File(imageUrl);

    await imageRef.putFile(file);

    return imageRef.getDownloadURL();
  }
}
