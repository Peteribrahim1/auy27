import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../../resources/auth_methods.dart';
import '../../resources/styles.dart';
import '../../utils/utils.dart';
import '../polling_modal.dart';
import 'church_screen.dart';

class AddChurch extends StatefulWidget {
  AddChurch({super.key});
  String? poll;

  @override
  State<AddChurch> createState() => _AddChurchState();
}

class _AddChurchState extends State<AddChurch> {
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
  List<dynamic> WardMasters = [];
  List<dynamic> Ward = [];

  String? lgaId;
  String? selectedLga;
  String? wardId;
  String? selectedWard;
  String? insId;
  String? selectedIns;

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

    String res = await AuthMethods().saveChurch(
      name: _nameController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      denomination: _denominationController.text,
      lga: selectedLga.toString(),
      ward: selectedWard.toString(),
      file: _image,
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
            builder: (context) => const ChurchScreen(
                  category: 'Church',
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
          'Add Church',
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
                hintText: 'name of church*',
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
                hintText: 'name of representative',
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
                hintText: 'denomination',
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
            const SizedBox(height: 20),
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
                hintText: 'number of members',
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
              this.lgaId,
              this.Lga,
              contentPadding: 16,
              paddingLeft: 0,
              paddingRight: 0,
              (onChangedVal) {
                var fid = this.lgaId = onChangedVal;
                //  print('selected faculty: $onChangedVal');

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
              'select ward',
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
                  //  print(this.selectedWard);
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
                    if (_nameController.text.isNotEmpty
                        // _phoneController.text.isNotEmpty &&
                        // _addressController.text.isNotEmpty &&
                        // _membersController.text.isNotEmpty &&
                        // _nameOfRepController.text.isNotEmpty &&
                        // _denominationController.text.isNotEmpty &&
                        // _image != null
                        //    selectedLga.toString() != null
                        ) {
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
                          child: CupertinoActivityIndicator(
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
