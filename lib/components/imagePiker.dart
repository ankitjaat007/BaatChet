import 'package:image_picker/image_picker.dart';

Future<String> getImageFormGallery() async {
  // ignore: invalid_use_of_visible_for_testing_member
  var getImage = await ImagePicker.platform
      .getImageFromSource(source: ImageSource.gallery);

  String image = '';

  if (getImage != null) {
    image = getImage.path;
  }

  return image;
}

// ===============================================
Future<String> getImageFormCamra() async {
  var getImage =
      // ignore: invalid_use_of_visible_for_testing_member
      await ImagePicker.platform.getImageFromSource(source: ImageSource.camera);
  String image = '';
  if (getImage != null) {
    image = getImage.path;
  }
  return image;
}
