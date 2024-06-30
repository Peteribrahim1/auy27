import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../resources/auth_methods.dart';
import '../../resources/styles.dart';
import '../../utils/utils.dart';
import '../camera_modal.dart';
import '../polling_modal.dart';
import 'masjid_screen.dart';

class AddMasjid extends StatefulWidget {
  AddMasjid({super.key});
  String? poll;

  @override
  State<AddMasjid> createState() => _AddMasjidState();
}

class _AddMasjidState extends State<AddMasjid> {
  Uint8List? _image;

  void _selectImageFromGallery() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void _selectImageFromCamera() async {
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

  List<dynamic> Lga = [];

  String? lgaId;
  // String? lgaId;
  // String? selectedLga;
  String? selectedLga;

  @override
  void initState() {
    super.initState();
    this.Lga.add({"id": 1, "name": "Akko"});
    this.Lga.add({"id": 2, "name": "Balanga"});
    this.Lga.add({"id": 3, "name": "Billiri"});
    this.Lga.add({"id": 4, "name": "Dukku"});
    this.Lga.add({"id": 5, "name": "Funakaye"});
    this.Lga.add({"id": 6, "name": "Gombe"});
    this.Lga.add({"id": 7, "name": "Kaltungo"});
    this.Lga.add({"id": 8, "name": "Kwami"});
    this.Lga.add({"id": 9, "name": "Nafada"});
    this.Lga.add({"id": 10, "name": "Shongom"});
    this.Lga.add({"id": 11, "name": "Yamaltu"});
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nameOfRepController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _denominationController = TextEditingController();
  final TextEditingController _membersController = TextEditingController();
  final TextEditingController _ninController = TextEditingController();
  final TextEditingController _bvnController = TextEditingController();
  final TextEditingController _voterController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _nameOfRepController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _denominationController.dispose();
    _membersController.dispose();
    _ninController.dispose();
    _bvnController.dispose();
    _voterController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  void _saveData() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().saveMasjid(
      name: _nameController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      denomination: _denominationController.text,
      lga: selectedLga.toString(),
      file: _image!,
      nameRep: _nameOfRepController.text,
      members: _membersController.text,
      nin: _ninController.text,
      bvn: _bvnController.text,
      voter: _voterController.text,
      polls: widget.poll.toString(),
    );

    setState(() {
      _isLoading = false;
      _nameController.text = '';
      _nameOfRepController.text = '';
      _phoneController.text = '';
      _addressController.text = '';
      _denominationController.text = '';
      _membersController.text = '';
      _ninController.text = '';
      _bvnController.text = '';
      _voterController.text = '';
      selectedLga = null;
      selectedLga = null;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Record saved successfully!'),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MasjidScreen(
                  category: 'Masjid',
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Add Masjid',
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(47, 79, 79, 1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: _selectImageFromGallery,
                      child: Icon(
                        Icons.camera,
                        size: 50,
                        color: const Color.fromRGBO(47, 79, 79, 1),
                      ),
                    ),
                    Text('Gallery'),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: _selectImageFromCamera,
                      child: Icon(
                        Icons.add_a_photo,
                        size: 50,
                        color: const Color.fromRGBO(47, 79, 79, 1),
                      ),
                    ),
                    Text('Camera'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Center(
              child: Container(
                child: _image != null
                    ? Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: MemoryImage(
                                _image!), // Replace 'background.jpg' with your image asset path
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(),
              ),
            ),
            // Center(
            //   child: _image != null
            //       ? Container(
            //           width: 200,
            //           height: 200,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(12),
            //             image: DecorationImage(
            //               image: MemoryImage(
            //                   _image!), // Replace 'background.jpg' with your image asset path
            //               fit: BoxFit.cover,
            //             ),
            //           ))
            //       : InkWell(
            //           onTap: () {
            //             showModalBottomSheet(
            //               context: context,
            //               builder: (context) => const CameraModal(),
            //             );
            //           },
            //           child: Icon(
            //             Icons.add_a_photo,
            //             size: 50,
            //             color: const Color.fromRGBO(47, 79, 79, 1),
            //           ),
            //         ),
            // ),
            SizedBox(height: 15),
            TextField(
              maxLength: 25,
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                counterText: "",
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.drive_file_rename_outline,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'name of masjid*',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(47, 79, 79, 1), width: 1),
                ),
                hintStyle: Styles.hintTextStyle,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              maxLength: 25,
              controller: _nameOfRepController,
              decoration: InputDecoration(
                filled: true,
                counterText: "",
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.drive_file_rename_outline,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'name of representative*',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(47, 79, 79, 1), width: 1),
                ),
                hintStyle: Styles.hintTextStyle,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.phone,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'phone*',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(47, 79, 79, 1), width: 1),
                ),
                hintStyle: Styles.hintTextStyle,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _ninController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.drive_file_rename_outline,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'nin',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(47, 79, 79, 1), width: 1),
                ),
                hintStyle: Styles.hintTextStyle,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _bvnController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.drive_file_rename_outline,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'bvn',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(47, 79, 79, 1), width: 1),
                ),
                hintStyle: Styles.hintTextStyle,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _voterController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.drive_file_rename_outline,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'voter card number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(47, 79, 79, 1), width: 1),
                ),
                hintStyle: Styles.hintTextStyle,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.location_on,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'address*',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(20, 10, 38, 1), width: 1),
                ),
                hintStyle: Styles.hintTextStyle,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _denominationController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.drive_file_rename_outline_outlined,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'sect*',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(20, 10, 38, 1), width: 1),
                ),
                hintStyle: Styles.hintTextStyle,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _membersController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.drive_file_rename_outline_outlined,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'number of members*',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(20, 10, 38, 1), width: 1),
                ),
                hintStyle: Styles.hintTextStyle,
              ),
            ),
            const SizedBox(height: 15),
            FormHelper.dropDownWidget(
              context,
              'select lga*',
              this.lgaId,
              this.Lga,
              contentPadding: 16,
              paddingLeft: 0,
              paddingRight: 0,
              (onChangedVal) {
                var fid = this.lgaId = onChangedVal;
                print('selected faculty: $onChangedVal');

                // this.LGA = this
                //     .LGAMasters
                //     .where(
                //       (departmentItem) =>
                //           departmentItem["ParentId"].toString() ==
                //           onChangedVal.toString(),
                //     )
                //     .toList();
                // this.lgaId = null;
                setState(() {});

                for (var element in this.Lga) {
                  if (element['id'] == int.parse(fid)) {
                    this.selectedLga = element['name'];
                  }
                }
                setState(() {
                  print(this.selectedLga);
                });
              },
              (onValidateVal) {
                if (onValidateVal == null) {
                  return 'Please select';
                }
                return null;
              },
              borderColor: Color.fromRGBO(20, 10, 38, 1),
              borderRadius: 15,
            ),
            InkWell(
              onTap: () async {
                widget.poll = await showModalBottomSheet(
                  context: context,
                  builder: (context) => const PollingModal(),
                );
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(
                            15.0) //                 <--- border radius here
                        ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(widget.poll == null
                        ? 'polling unit'
                        : widget.poll.toString()),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 35),
            Center(
              child: SizedBox(
                height: 52,
                width: 280,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_nameController.text.isNotEmpty &&
                        _phoneController.text.isNotEmpty &&
                        _addressController.text.isNotEmpty &&
                        _membersController.text.isNotEmpty &&
                        _nameOfRepController.text.isNotEmpty &&
                        _denominationController.text.isNotEmpty &&
                        _image != null &&
                        selectedLga.toString() != null) {
                      _saveData();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Required fields cannot be empty!'),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(47, 79, 79, 1),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Submit',
                          style: Styles.buttonTextStyle,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
