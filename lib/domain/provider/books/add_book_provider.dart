import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddBooksProvider extends ChangeNotifier {
  String? filePath;
  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['epub'],
      );

      if (result != null) {
        filePath = result.files.single.path;
        notifyListeners();
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<String> uploadEpubFile(File file) async {
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('epub_files')
          .child(
              'your_file_name.epub'); // Change 'your_file_name' to a unique name

      final UploadTask uploadTask = storageReference.putFile(file);

      final TaskSnapshot downloadUrl = await uploadTask;

      if (downloadUrl.state == TaskState.success) {
        final String url = await storageReference.getDownloadURL();
        return url; // This is the download URL of the uploaded ePub file
      } else {
        throw 'File upload failed';
      }
    } catch (e) {
      print('Error uploading ePub file: $e');
      return '';
    }
  }

  Future<File> downloadEpubFile(String downloadUrl) async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      final File epubFile = File(
          '$tempPath/your_file_name.epub'); // Change 'your_file_name' to match the file name used during upload

      final Reference storageReference =
          FirebaseStorage.instance.refFromURL(downloadUrl);

      await storageReference.writeToFile(epubFile);

      return epubFile;
    } catch (e) {
      print('Error downloading ePub file: $e');
      return null;
    }
  }
}
