abstract class ImageRepository {
  Future<String?> pickImageFromGallery();

  Future<String> saveImage(
    String imageUrl,
    String saveUrl,
  );
}
