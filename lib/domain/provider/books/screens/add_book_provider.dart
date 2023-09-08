import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class AddBooksProvider extends ChangeNotifier {
  String? filePath;
  String? epubUrl = '';
  String? coverImage;
  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['epub'],
      );

      if (result != null) {
        filePath = result.files.single.path;
        final File file = File(result.files.single.path!);
        await uploadEpubFile(file);
        // await addEpubFile(file.path);
        notifyListeners();
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> uploadEpubFile(File file) async {
    try {
      final storage = FirebaseStorage.instance;

      String bookId = Uuid().v1();

      final Reference storageReference = storage
          .ref()
          .child('epub_files')
          .child(bookId); // Change 'your_file_name' to a unique name

      final UploadTask uploadTask = storageReference.putFile(file);

      await cloudAdd(file).then((_) async {
        final TaskSnapshot downloadUrl = await uploadTask;

        if (downloadUrl.state == TaskState.success) {
          final String url = await storageReference.getDownloadURL();
          epubUrl = url;

          // Check if the file already exists in the Firebase Storage bucket
          final ListResult result = await storage.ref('epub_files').listAll();
          bool fileExists = false;
          for (var file in result.items) {
            if (file.name == 'your_file_name.epub') {
              fileExists = true;
              break;
            }
          }

          if (!fileExists) {
            // Upload the file to the Firebase Storage bucket
            await storageReference.putFile(file);
          }

          Map<String, dynamic> data = {
            "url": url,
            "uid": bookId,
            "coverImageUrl": coverImage
          };
          await FirebaseFirestore.instance
              .collection('epub_files')
              .doc(bookId)
              .set(data);
          notifyListeners(); // This is the download URL of the uploaded ePub file
        } else {
          throw 'File upload failed';
        }
      });
    } catch (e) {
      print('Error uploading ePub file: <span class="math-inline">e');
    }
  }

  Future<void> addEpubFile(String filePath) async {
    // Get the file path of the epub file.
    final String filePath = 'path/to/epub/file.epub';

    // Create a reference to the Firebase Storage bucket.
    final storageRef = FirebaseStorage.instance.ref('epub_files');

    // Create a file object for the epub file.
    final file = File(filePath);

    // Upload the file to the Firebase Storage bucket.
    final uploadTask = storageRef.putFile(file);

    // Listen for the completion of the upload task.
    uploadTask.whenComplete(() {
      // The file has been uploaded.
      print('The file has been uploaded.');
    });
  }

  Future<void> cloudAdd(File file) async {
    final Reference storageref = FirebaseStorage.instance
        .ref()
        .child('epub_cover_images/{DateTime.now().millisecondsSinceEpoch}');

    final UploadTask uploadTask = storageref.putFile(file);
    TaskSnapshot snap = await uploadTask;

    final String downloadUrl = await snap.ref.getDownloadURL();
    coverImage = downloadUrl;
    notifyListeners();
  }

// Future<File> downloadEpubFile(String downloadUrl) async {
//   try {
//     final storageRef = FirebaseStorage.instance.ref('epub_files/your_file_name.epub');
//   final downloadUrl = await storageRef.getDownloadURL();

//   final directory = await getApplicationDocumentsDirectory();
//   final file = File('${directory.path}/your_file_name.epub');

//  final bytes = await Stream.fromIterable(downloadUrl as Iterable).toString();
//   await file.writeAsString(bytes);
//   } catch (e) {
//     print('Error downloading ePub file: $e');
//     return ;
//   }
// }
}
