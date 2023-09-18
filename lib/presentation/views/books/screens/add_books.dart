import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:scribbleverse/domain/provider/books/screens/add_book_provider.dart';

import '../../../../config/theams/colors.dart';

class AddBooks extends StatelessWidget {
  const AddBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ColorFiltered(
            colorFilter: backgroundFilter,
            child: Image.asset(
              'lib/data/datasources/local/images/istockphoto-1353780638-612x612.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Center(
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            await Provider.of<AddBooksProvider>(context,
                                    listen: false)
                                .pickFile();
                          },
                          // ignore: prefer_const_constructors
                          child: Text('Add file')),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> uploadEPUBFile(File file) async {
    try {
      // Create a reference to the location you want to upload to in Firebase Storage
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('epub_files/${DateTime.now()}.epub');

      // Upload the file to Firebase Storage
      await storageReference.putFile(file);
    } catch (e) {
      rethrow;
    }
  }
}
