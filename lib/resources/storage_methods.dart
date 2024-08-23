import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List? file, bool isPost) async {
    String downloadUrl = '';
    if (file != null) {
      Reference ref = _storage
          .ref()
          .child(childName)
          .child(DateTime.now().microsecondsSinceEpoch.toString());
      UploadTask uploadTask = ref.putData(file);
      //  UploadTask uploadTask = ref.putFile(file2!);
      TaskSnapshot snap = await uploadTask;
      downloadUrl = await snap.ref.getDownloadURL();
    }
    return downloadUrl;
  }
}

//
// import 'dart:typed_data';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
//
// class StorageMethods {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // Adding image to Firebase Storage with optimized compression
//   Future<String> uploadImageToStorage(
//       String childName, Uint8List? file, bool isPost) async {
//     String downloadUrl = '';
//     if (file != null) {
//       // Downscale the image before compression
//       Uint8List? downscaledFile = _downscaleImage(file, maxWidth: 1080);
//
//       // Compress the image
//       Uint8List? compressedFile = await _compressImage(downscaledFile!);
//
//       if (compressedFile != null) {
//         Reference ref = _storage
//             .ref()
//             .child(childName)
//             .child(DateTime.now().microsecondsSinceEpoch.toString());
//         UploadTask uploadTask = ref.putData(compressedFile);
//         TaskSnapshot snap = await uploadTask;
//         downloadUrl = await snap.ref.getDownloadURL();
//       }
//     }
//     return downloadUrl;
//   }
//
//   // Downscale the image to reduce processing time
//   Uint8List _downscaleImage(Uint8List imageData, {int maxWidth = 1080}) {
//     img.Image? image = img.decodeImage(imageData);
//     if (image == null) return imageData;
//
//     // Calculate new dimensions while maintaining the aspect ratio
//     if (image.width > maxWidth) {
//       int newHeight = (image.height * maxWidth) ~/ image.width;
//       image = img.copyResize(image, width: maxWidth, height: newHeight);
//     }
//
//     return Uint8List.fromList(
//         img.encodeJpg(image, quality: 90)); // Higher initial quality
//   }
//
//   // Compress the image to be under 100KB
//   Future<Uint8List?> _compressImage(Uint8List image) async {
//     img.Image? decodedImage = img.decodeImage(image);
//     if (decodedImage == null) return null;
//
//     int quality = 70; // Start with a lower quality
//     Uint8List? compressedImage;
//     do {
//       compressedImage = Uint8List.fromList(
//         img.encodeJpg(decodedImage, quality: quality),
//       );
//       quality -= 5; // Reduce quality in larger steps
//     } while (compressedImage.length > 100 * 1024 && quality > 0);
//
//     return compressedImage;
//   }
// }
