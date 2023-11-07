import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

class ImageService {
  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
  }

  Future<String> saveToFirebase(Uint8List img) async {
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = _storage.ref().child("profileImage").child(uniqueName);
    TaskSnapshot snapshot = await ref.putData(img).whenComplete(() {});
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
