import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class AddBooksProvider extends ChangeNotifier {
  String? filePath;
  String? epubUrl = '';
  String? coverImage;
  File? fileLocation;
  Uint8List? eCoverted;

  List<String> coverUri = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBkL3XFNQ8czrS_Vy6-leceDojSYkdXl5G1w&usqp=CAU',
    'https://d1cm35kbp068hs.cloudfront.net/o1unljvghz/thumbnail.jpg',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/contemporary-fiction-night-time-book-cover-design-template-1be47835c3058eb42211574e0c4ed8bf_screen.jpg?ts=1637012564',
    'https://imgv3.fotor.com/images/gallery/Fiction-Book-Covers.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2KuFBHfsxQZK3XSsXtiRqaXOWcRn2MId1Tw&usqp=CAU',
    'https://marketplace.canva.com/EAFBN69UM-A/1/0/1003w/canva-black-red-vintage-time-book-cover-N4kq526KmFo.jpg'
  ];

  // Future<void> pickFile() async {
  //   try {
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['epub'],
  //     );

  //     if (result != null) {
  //       filePath = result.files.single.path;
  //       final File file = File(result.files.single.path!);
  //       await uploadEpubFile(file);
  //       // await addEpubFile(file.path);
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print('Error picking file: $e');
  //   }
  // }
  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['epub', 'epub+zip'],
          allowMultiple: false);

      if (result != null) {
        filePath = result.files.single.path;
        final file = File(result.files.single.path!);

        await uploadEpubFile(file);
        // await addEpubFile(file.path);
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadEpubFile(File file) async {
    try {
      final storage = FirebaseStorage.instance;

      String bookId = const Uuid().v1();

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
            if (file.name == '$bookId.epub') {
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
      rethrow;
    }
  }

  Future<void> addEpubFile(String filePath) async {
    // Get the file path of the epub file.
    const String filePath = 'path/to/epub/file.epub';

    // Create a reference to the Firebase Storage bucket.
    final storageRef = FirebaseStorage.instance.ref('epub_files');

    // Create a file object for the epub file.
    final file = File(filePath);

    // Upload the file to the Firebase Storage bucket.
    final uploadTask = storageRef.putFile(file);

    // Listen for the completion of the upload task.
    uploadTask.whenComplete(() {
      // The file has been uploaded.
    });
  }

  Future<void> cloudAdd(File file) async {
    final Reference storageref = FirebaseStorage.instance
        .ref()
        .child('epub_cover_images/${DateTime.now().millisecondsSinceEpoch}');

    final UploadTask uploadTask = storageref.putFile(file);
    TaskSnapshot snap = await uploadTask;

    final String downloadUrl = await snap.ref.getDownloadURL();
    coverImage = downloadUrl;
    notifyListeners();
  }

  Future downloadEpubFile(String downloadUrl, String fileName) async {
    try {
      final storageRef = FirebaseStorage.instance.ref('epub_files/$fileName');
      final downloadUrl = await storageRef.getDownloadURL();

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');

      final bytes = Stream.fromIterable(downloadUrl.characters).toString();
      final book = await file.writeAsString(bytes);
      fileSet(book);
    } catch (e) {
      rethrow;
    }
  }

  fileSet(File value) {
    fileLocation = value;
    notifyListeners();
  }

  eSet(Uint8List value) {
    eCoverted = value;
    notifyListeners();
  }

  // Future getEpubFileFromFirebaseAsUnit8List(String fileName) async {
  //   try {
  //     // final storageRef = FirebaseStorage.instance.ref('epub_files/$fileName');
  //     final storageRef = FirebaseStorage.instance.ref(
  //         'https://firebasestorage.googleapis.com/v0/b/scribbleverse-b95d4.appspot.com/o/epub_files%2FHalf_Girlfriend_-_Chetan_Bhagat%20(2).epub?alt=media&token=fc869664-f1c8-4d5e-8c50-a362fe89a30f');

  //     final downloadUrl = await storageRef.getDownloadURL();

  //     final response = await http.get(Uri.parse(downloadUrl));

  //     final bytes = response.bodyBytes;

  //     eSet(bytes);
  //   } catch (e) {
  //     print('Error downloading ePub file: $e');
  //     throw e;
  //   }
  // }
  Future getEpubFileFromFirebaseAsUnit8List(String fileName) async {
    try {
// final storageRef = FirebaseStorage.instance.ref('epub_files/$fileName');
      final storageRef = FirebaseStorage.instance.refFromURL(fileName);

      final downloadUrl = await storageRef.getDownloadURL();

      final response = await http.get(Uri.parse(downloadUrl));

      final bytes = response.bodyBytes;

      eSet(bytes);
    } catch (e) {
      rethrow;
    }
  }
}
