import 'package:image_picker/image_picker.dart';
import 'dart:io';

Future<File> getImageFromGallery() async{
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  return image;
}


Future<File> getImageFromCamera() async{
  var image = await ImagePicker.pickImage(source: ImageSource.camera);
  return image;
}

