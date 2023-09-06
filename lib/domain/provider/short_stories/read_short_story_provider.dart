import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../config/theams/colors.dart';
import '../../../config/theams/fonts.dart';

class ReadShortStoriesProvider extends ChangeNotifier {
  int substringStart = 0;
  int substringEnd = 100;
  String imageUri = '';
  File? photo;
  String text =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum";
  int? pageCount;
  String contentType = 'Content type';
  String? sorting_content = 'All';
  TextEditingController shortStoryNameController = TextEditingController();
  TextEditingController shortStoryDiscriptionController =
      TextEditingController();
  TextEditingController controller = TextEditingController();
  getPageNumbers() {
    double value = text.length / 500;
    pageCount = value.toInt() - 1;
    notifyListeners();
  }

  textChange(String value) {
    text = value;
    notifyListeners();
  }

  changeContentType(String value) {
    contentType = value;
    notifyListeners();
  }

  sortContent(String value) {
    sorting_content = value;
    notifyListeners();
  }

  setBackSubstring() {
    substringStart = 0;
    substringEnd = 100;
    notifyListeners();
  }

  contentShedulingInPages() {
    substringStart = substringStart + 50;
    substringEnd = substringEnd + 50;
    notifyListeners();
    // }
  }

  endPageContent() {
    substringEnd = text.length;
    notifyListeners();
  }

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      final phototemp = File(image.path);

      photo = phototemp;
      notifyListeners();
    } else {
      return;
    }
  }

  Future<void> cloudAdd(File file) async {
    final Reference storageref = FirebaseStorage.instance
        .ref()
        .child('userProfiles/${DateTime.now().millisecondsSinceEpoch}');

    final UploadTask uploadTask = storageref.putFile(file);
    TaskSnapshot snap = await uploadTask;

    final String downloadUrl = await snap.ref.getDownloadURL();
    imageUri = downloadUrl;
    notifyListeners();
  }

  Future<dynamic> selectPhoto(BuildContext context) async {
    await showModalBottomSheet(
        backgroundColor: black,
        context: context,
        builder: ((context) => BottomSheet(
            elevation: 0.5,
            backgroundColor: Colors.black26,
            onClosing: () {},
            builder: ((context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.camera,
                      color: white,
                    ),
                    title: Text(
                      'Camara',
                      style: normal,
                    ),
                    onTap: () async {
                      Navigator.of(context).pop();
                      getImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.filter,
                      color: white,
                    ),
                    title: Text(
                      'Gallery',
                      style: normal,
                    ),
                    onTap: () async {
                      Navigator.of(context).pop();
                      getImage(ImageSource.gallery);
                    },
                  )
                ],
              );
            }))));
    notifyListeners();
  }
}
