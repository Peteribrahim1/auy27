import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/styles.dart';
import '../utils/utils.dart';
import 'islamiya/add_islamiya.dart';

class CameraModal extends StatefulWidget {
  const CameraModal({super.key});

  @override
  State<CameraModal> createState() => _CameraModalState();
}

class _CameraModalState extends State<CameraModal> {
  Uint8List? _image;

  void selectImageFromGallery() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void selectImageFromCamera() async {
    Uint8List imgc = await pickImage(ImageSource.camera);
    setState(() {
      _image = imgc;
    });
  }

  // void selectImage() async {
  //   Uint8List img = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     _image = img;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: selectImageFromCamera,
              child: Column(
                children: [
                  Icon(Icons.add_a_photo, size: 50),
                  Text('Camera'),
                ],
              ),
            ),
            InkWell(
              onTap: selectImageFromGallery,
              child: Column(
                children: [
                  Icon(Icons.camera, size: 50),
                  Text('Gallery'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
