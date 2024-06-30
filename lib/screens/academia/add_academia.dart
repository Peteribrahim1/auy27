import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../resources/auth_methods.dart';
import '../../resources/styles.dart';
import '../../utils/utils.dart';
import '../polling_modal.dart';
import 'academia_screen.dart';

class AddAcademia extends StatefulWidget {
  AddAcademia({super.key});
  String? poll;

  @override
  State<AddAcademia> createState() => _AddAcademiaState();
}

class _AddAcademiaState extends State<AddAcademia> {
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
  List<dynamic> institution = [];
  List<dynamic> WardMasters = [];
  List<dynamic> Ward = [];

  String? lgaId;
  String? wardId;
  String? selectedWard;
  String? selectedLga;
  String? insId;
  String? selectedIns;

  @override
  void initState() {
    super.initState();

    this
        .institution
        .add({"id": 1, "name": "Gombe State College of Legal Studies, Nafada"});
    this
        .institution
        .add({"id": 2, "name": "Gombe State College of Education, Billiri"});
    this.institution.add(
        {"id": 3, "name": "Federal College of Education(Technical), Gombe"});
    this.institution.add({
      "id": 4,
      "name": "Federal College of Horticultural Technology, Dadin Kowa"
    });
    this
        .institution
        .add({"id": 5, "name": "Gombe State College of Nursing and Midwifery"});
    this.institution.add({
      "id": 6,
      "name": "Gombe State College of Health Sciences and Technology, Kaltungo"
    });
    this.institution.add({"id": 7, "name": "Federal Polytechnic, Kaltungo"});
    this.institution.add({"id": 8, "name": "Gombe State Polytechnic Bajoga"});
    this.institution.add({"id": 9, "name": "Federal University Kashere"});
    this.institution.add({"id": 10, "name": "Gombe State University"});
    this.institution.add({"id": 11, "name": "North-Eastern University"});

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
    this.Lga.add({"id": 11, "name": "Yamaltu-Deba"});

    this.WardMasters = [
      {"ID": 1, "Name": "AKKO", "ParentId": 1},
      {"ID": 2, "Name": "GARKO", "ParentId": 1},
      {"ID": 3, "Name": "KALSHINGI", "ParentId": 1},
      {"ID": 4, "Name": "KASHERE", "ParentId": 1},
      {"ID": 5, "Name": "KUMO CENTRAL", "ParentId": 1},
      {"ID": 6, "Name": "KUMO EAST", "ParentId": 1},
      {"ID": 7, "Name": "KUMO NORTH", "ParentId": 1},
      {"ID": 8, "Name": "KUMO WEST", "ParentId": 1},
      {"ID": 9, "Name": "PINDIGA", "ParentId": 1},
      {"ID": 10, "Name": "TUMU", "ParentId": 1},
      {"ID": 11, "Name": "TUKULMA", "ParentId": 1},
      {"ID": 1, "Name": "BAMBAM", "ParentId": 2},
      {"ID": 2, "Name": "BANGU", "ParentId": 2},
      {"ID": 3, "Name": "DADIYA", "ParentId": 2},
      {"ID": 4, "Name": "GELENGU / BALANGA", "ParentId": 2},
      {"ID": 5, "Name": "KINDIYO", "ParentId": 2},
      {"ID": 6, "Name": "KULANI / DEGRE / SIKKAM", "ParentId": 2},
      {"ID": 7, "Name": "MWONA", "ParentId": 2},
      {"ID": 8, "Name": "NYUWAR / JESSU", "ParentId": 2},
      {"ID": 9, "Name": "SWA / REF / W. WAJA", "ParentId": 2},
      {"ID": 10, "Name": "TALASSE / DONG / REME", "ParentId": 2},
      {"ID": 1, "Name": "BAGANJE NORTH", "ParentId": 3},
      {"ID": 2, "Name": "BAGANJE SOUTH", "ParentId": 3},
      {"ID": 3, "Name": "BARE", "ParentId": 3},
      {"ID": 4, "Name": "BILLIRI NORTH", "ParentId": 3},
      {"ID": 5, "Name": "BILLIRI SOUTH", "ParentId": 3},
      {"ID": 6, "Name": "KALMAI", "ParentId": 3},
      {"ID": 7, "Name": "TAL", "ParentId": 3},
      {"ID": 8, "Name": "TANGLANG", "ParentId": 3},
      {"ID": 9, "Name": "TODI", "ParentId": 3},
      {"ID": 10, "Name": "TUDU KWAYA", "ParentId": 3},
      {"ID": 1, "Name": "GOMBE ABBA", "ParentId": 4},
      {"ID": 2, "Name": "HASHIDU", "ParentId": 4},
      {"ID": 3, "Name": "JAMARI", "ParentId": 4},
      {"ID": 4, "Name": "KUNDE", "ParentId": 4},
      {"ID": 5, "Name": "LAFIYA", "ParentId": 4},
      {"ID": 6, "Name": "MALALA", "ParentId": 4},
      {"ID": 7, "Name": "WAZIRI NORTH", "ParentId": 4},
      {"ID": 8, "Name": "WAZIRI SOUTH/CENTRAL", "ParentId": 4},
      {"ID": 9, "Name": "WURO TALE", "ParentId": 4},
      {"ID": 10, "Name": "ZANGE", "ParentId": 4},
      {"ID": 11, "Name": "ZAUNE", "ParentId": 4},
      {"ID": 1, "Name": "ASHAKA / MAGABA", "ParentId": 5},
      {"ID": 2, "Name": "BAGE", "ParentId": 5},
      {"ID": 3, "Name": "BAJOGA WEST", "ParentId": 5},
      {"ID": 4, "Name": "BAJOGA EASTE", "ParentId": 5},
      {"ID": 5, "Name": "BODOR/TILDE", "ParentId": 5},
      {"ID": 6, "Name": "JILLAHI", "ParentId": 5},
      {"ID": 7, "Name": "KUPTO", "ParentId": 5},
      {"ID": 8, "Name": "RIBADU", "ParentId": 5},
      {"ID": 9, "Name": "TONGO", "ParentId": 5},
      {"ID": 10, "Name": "WAWA/WAKKULUTU", "ParentId": 5},
      {"ID": 1, "Name": "AJIYA", "ParentId": 6},
      {"ID": 2, "Name": "BAJOGA", "ParentId": 6},
      {"ID": 3, "Name": "BOLARI EAST", "ParentId": 6},
      {"ID": 4, "Name": "BOLARI WEST", "ParentId": 6},
      {"ID": 5, "Name": "DAWAKI", "ParentId": 6},
      {"ID": 6, "Name": "HERWAGANA", "ParentId": 6},
      {"ID": 7, "Name": "JEKA DAFARI", "ParentId": 6},
      {"ID": 8, "Name": "KUMBIYA â€“ KUMBIYA", "ParentId": 6},
      {"ID": 9, "Name": "NASARAWO", "ParentId": 6},
      {"ID": 10, "Name": "PANTAMI", "ParentId": 6},
      {"ID": 11, "Name": "SHAMAKI", "ParentId": 6},
      {"ID": 1, "Name": "AWAK", "ParentId": 7},
      {"ID": 2, "Name": "BULE / KALTIN", "ParentId": 7},
      {"ID": 3, "Name": "KALTUNGO WEST", "ParentId": 7},
      {"ID": 4, "Name": "KALTUNGO EAST", "ParentId": 7},
      {"ID": 5, "Name": "KAMO", "ParentId": 7},
      {"ID": 6, "Name": "TULA BAULE", "ParentId": 7},
      {"ID": 7, "Name": "TULA WANGE", "ParentId": 7},
      {"ID": 8, "Name": "TULA YIRI", "ParentId": 7},
      {"ID": 9, "Name": "TUNGO", "ParentId": 7},
      {"ID": 10, "Name": "TURE", "ParentId": 7},
      {"ID": 1, "Name": "BOJUDE", "ParentId": 8},
      {"ID": 2, "Name": "DABAN FULANI", "ParentId": 8},
      {"ID": 3, "Name": "DOHO", "ParentId": 8},
      {"ID": 4, "Name": "DUKUL", "ParentId": 8},
      {"ID": 5, "Name": "GADAM", "ParentId": 8},
      {"ID": 6, "Name": "JURARA", "ParentId": 8},
      {"ID": 7, "Name": "KOMFULATA", "ParentId": 8},
      {"ID": 8, "Name": "KWAMI", "ParentId": 8},
      {"ID": 9, "Name": "MALAM SIDI", "ParentId": 8},
      {"ID": 10, "Name": "MALLERI", "ParentId": 8},
      {"ID": 1, "Name": "BARWO/NASARAWO", "ParentId": 9},
      {"ID": 2, "Name": "BARWO WINDE", "ParentId": 9},
      {"ID": 3, "Name": "BIRIN BOLEWA", "ParentId": 9},
      {"ID": 4, "Name": "BIRIN FULANI EAST", "ParentId": 9},
      {"ID": 5, "Name": "BIRIN FULANI WEST", "ParentId": 9},
      {"ID": 6, "Name": "GUDUKKU", "ParentId": 9},
      {"ID": 7, "Name": "JIGAWA", "ParentId": 9},
      {"ID": 8, "Name": "NAFADA CENTRAL", "ParentId": 9},
      {"ID": 9, "Name": "NAFADA EAST", "ParentId": 9},
      {"ID": 10, "Name": "NAFADA WEST", "ParentId": 9},
      {"ID": 1, "Name": "BANGUNJI", "ParentId": 10},
      {"ID": 2, "Name": "BOH", "ParentId": 10},
      {"ID": 3, "Name": "BURAK", "ParentId": 10},
      {"ID": 4, "Name": "FILIYA", "ParentId": 10},
      {"ID": 5, "Name": "GUNDALE", "ParentId": 10},
      {"ID": 6, "Name": "GWANDUM", "ParentId": 10},
      {"ID": 7, "Name": "KULISHIN", "ParentId": 10},
      {"ID": 8, "Name": "KUSHI", "ParentId": 10},
      {"ID": 9, "Name": "LALAIPIDO", "ParentId": 10},
      {"ID": 10, "Name": "LAPAN", "ParentId": 10},
      {"ID": 1, "Name": "DEBA", "ParentId": 11},
      {"ID": 2, "Name": "DIFA/LUBO / KINAFA", "ParentId": 11},
      {"ID": 3, "Name": "GWANI / SHINGA / WADE", "ParentId": 11},
      {"ID": 4, "Name": "HINNA", "ParentId": 11},
      {"ID": 5, "Name": "JAGALI NORTH", "ParentId": 11},
      {"ID": 6, "Name": "JAGALI SOUTH", "ParentId": 11},
      {"ID": 7, "Name": "KANAWA/WAJARI", "ParentId": 11},
      {"ID": 8, "Name": "KURI /LANO / LAMBAM", "ParentId": 11},
      {"ID": 9, "Name": "KWADON / LIJI / KURBA", "ParentId": 11},
      {"ID": 10, "Name": "NONO / KUNWAL / W. BIRDEKA", "ParentId": 11},
      {"ID": 11, "Name": "ZAMBUK / KWALI", "ParentId": 11},
    ];
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _membersController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _rankController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
//  final TextEditingController _pollingController = TextEditingController();
  final TextEditingController _ninController = TextEditingController();
  final TextEditingController _bvnController = TextEditingController();
  final TextEditingController _voterController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _membersController.dispose();
    _institutionController.dispose();
    _rankController.dispose();
    _wardController.dispose();
    //   _pollingController.dispose();
    _qualificationController.dispose();
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

    String res = await AuthMethods().saveAcademia(
      name: _nameController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      lga: selectedLga.toString(),
      file: _image!,
      institution: selectedIns.toString(),
      rank: _rankController.text,
      ward: selectedWard.toString(),
      //  polling_unit: _pollingController.text,
      qualification: _qualificationController.text,
      nin: _ninController.text,
      bvn: _bvnController.text,
      voter: _voterController.text, polls: widget.poll.toString(),
    );

    setState(() {
      _isLoading = false;
      _nameController.text = '';
      _ninController.text = '';
      _bvnController.text = '';
      _voterController.text = '';
      // _pollingController.text = '';
      _qualificationController.text = '';
      _phoneController.text = '';
      _addressController.text = '';
      _membersController.text = '';
      selectedLga = null;
      selectedWard = null;
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
          builder: (context) => const AcademiaScreen(
            category: 'Academia',
          ),
        ),
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
          'Add Academia',
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
                hintText: 'name*',
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
            FormHelper.dropDownWidget(
              context,
              'select institution*',
              this.insId,
              this.institution,
              contentPadding: 16,
              paddingLeft: 0,
              paddingRight: 0,
              (onChangedVal) {
                var fid = this.insId = onChangedVal;
                print('selected institution: $onChangedVal');

                // this.Ward = this
                //     .WardMasters
                //     .where(
                //       (departmentItem) =>
                //           departmentItem["ParentId"].toString() ==
                //           onChangedVal.toString(),
                //     )
                //     .toList();
                // this.wardId = null;
                setState(() {});

                for (var element in this.institution) {
                  if (element['id'] == int.parse(fid)) {
                    this.selectedIns = element['name'];
                  }
                }
                setState(() {
                  print(this.selectedIns);
                });
              },
              (onValidateVal) {
                if (onValidateVal == null) {
                  return 'Please select institution';
                }
                return null;
              },
              borderColor: Color.fromRGBO(20, 10, 38, 1),
              borderRadius: 15,
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
            const SizedBox(height: 15),
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
            const SizedBox(height: 15),
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
              controller: _rankController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.drive_file_rename_outline_outlined,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'rank*',
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
              controller: _qualificationController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.drive_file_rename_outline_outlined,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'qualification*',
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

                this.Ward = this
                    .WardMasters
                    .where(
                      (departmentItem) =>
                          departmentItem["ParentId"].toString() ==
                          onChangedVal.toString(),
                    )
                    .toList();
                this.wardId = null;
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
            const SizedBox(height: 15),
            FormHelper.dropDownWidget(
              context,
              'select ward*',
              this.wardId,
              this.Ward,
              contentPadding: 16,
              paddingLeft: 0,
              paddingRight: 0,
              (onChangedVal) {
                var id = this.wardId = onChangedVal;

                print('selected department $onChangedVal');
                setState(() {});

                for (var element in this.Ward) {
                  if (element['ID'] == int.parse(id)) {
                    this.selectedWard = element['Name'];
                  }
                }
                setState(() {
                  print(this.selectedWard);
                });
              },
              (onValidate) {
                return null;
              },
              borderColor: Color.fromRGBO(20, 10, 38, 1),
              borderRadius: 15,
              optionValue: 'ID',
              optionLabel: 'Name',
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
            // TextField(
            //   controller: _pollingController,
            //   keyboardType: TextInputType.text,
            //   decoration: InputDecoration(
            //     filled: true,
            //     fillColor: Colors.white,
            //     prefixIcon: const Icon(
            //       Icons.drive_file_rename_outline_outlined,
            //       color: Color.fromRGBO(47, 79, 79, 1),
            //     ),
            //     contentPadding: const EdgeInsets.all(18),
            //     hintText: 'polling unit*',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(15),
            //       borderSide: const BorderSide(
            //           color: Color.fromRGBO(20, 10, 38, 1), width: 1),
            //     ),
            //     hintStyle: Styles.hintTextStyle,
            //   ),
            // ),
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
                        _qualificationController.text.isNotEmpty &&
                        // _pollingController.text.isNotEmpty &&
                        _rankController.text.isNotEmpty &&
                        _image != null &&
                        selectedLga.toString() != null &&
                        selectedWard.toString() != null &&
                        selectedIns.toString() != null) {
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
