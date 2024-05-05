import 'dart:typed_data';

import 'package:auy27/screens/residence/residence_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../resources/auth_methods.dart';
import '../../resources/styles.dart';
import '../../utils/utils.dart';

class AddResidence extends StatefulWidget {
  const AddResidence({super.key});

  @override
  State<AddResidence> createState() => _AddResidenceState();
}

class _AddResidenceState extends State<AddResidence> {
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

  List<dynamic> Lga = [];

  String? LgaId;
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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ninController = TextEditingController();
  final TextEditingController _bvnController = TextEditingController();
  final TextEditingController _voterController = TextEditingController();
  final TextEditingController _partyController = TextEditingController();
  final TextEditingController _pollingController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _ninController.dispose();
    _bvnController.dispose();
    _voterController.dispose();
    _partyController.dispose();
    _pollingController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  void _saveData() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().saveResidence(
      name: _nameController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      lga: selectedLga.toString(),
      file: _image!,
      nin: _ninController.text,
      bvn: _bvnController.text,
      voter: _voterController.text,
      party: _partyController.text,
      polling: _pollingController.text,
    );

    setState(() {
      _isLoading = false;
      _nameController.text = '';
      _phoneController.text = '';
      _addressController.text = '';
      _ninController.text = '';
      _bvnController.text = '';
      _voterController.text = '';
      _partyController.text = '';
      _pollingController.text = '';
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
            builder: (context) => const ResidenceScreen(
                  category: 'Residence',
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
          'Add Residence',
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
                hintText: 'name',
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
                hintText: 'phone',
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
              // maxLength: 11,
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
            const SizedBox(height: 15),
            TextField(
              //  maxLength: 11,
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
              //maxLength: 19,

              // counterText: "",
              controller: _voterController,
              keyboardType: TextInputType.text,
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
            const SizedBox(height: 15),
            TextField(
              //maxLength: 19,

              // counterText: "",
              controller: _partyController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.drive_file_rename_outline,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'party',
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
              //maxLength: 19,

              // counterText: "",
              controller: _pollingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.drive_file_rename_outline,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'polling unit',
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
              controller: _addressController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.location_on,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'address',
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
              'select lga',
              this.LgaId,
              this.Lga,
              contentPadding: 16,
              paddingLeft: 0,
              paddingRight: 0,
              (onChangedVal) {
                var fid = this.LgaId = onChangedVal;
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
                  return 'Please select faculty';
                }
                return null;
              },
              borderColor: Color.fromRGBO(20, 10, 38, 1),
              borderRadius: 15,
            ),
            // const SizedBox(height: 15),
            // FormHelper.dropDownWidget(
            //   context,
            //   'select lga',
            //   this.lgaId,
            //   this.LGA,
            //   contentPadding: 16,
            //   paddingLeft: 0,
            //   paddingRight: 0,
            //   (onChangedVal) {
            //     var id = this.lgaId = onChangedVal;
            //
            //     print('selected department $onChangedVal');
            //     setState(() {});
            //
            //     for (var element in this.LGA) {
            //       if (element['ID'] == int.parse(id)) {
            //         this.selectedLga = element['Name'];
            //       }
            //     }
            //     setState(() {
            //       print(this.selectedLga);
            //     });
            //   },
            //   (onValidate) {
            //     return null;
            //   },
            //   borderColor: Color.fromRGBO(20, 10, 38, 1),
            //   borderRadius: 15,
            //   optionValue: 'ID',
            //   optionLabel: 'Name',
            // ),
            const SizedBox(height: 35),
            Center(
              child: SizedBox(
                height: 52,
                width: 280,
                child: ElevatedButton(
                  onPressed: _saveData,
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
