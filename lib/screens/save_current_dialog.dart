import 'package:flutter/material.dart';

import '../resources/auth_methods.dart';
import '../resources/styles.dart';
import '../utils/utils.dart';

class SaveCurrentDialog extends StatefulWidget {
  const SaveCurrentDialog(
      {super.key,
      required this.latitude,
      required this.longitude,
      this.address});
  final double latitude;
  final double longitude;
  final String? address;

  @override
  State<SaveCurrentDialog> createState() => _SaveCurrentDialogState();
}

class _SaveCurrentDialogState extends State<SaveCurrentDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  void _saveData() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().saveGeneralCoordinates(
      name: _nameController.text,
      phone: _phoneController.text,
      category: _categoryController.text,
      latitude: widget.latitude,
      longitude: widget.longitude,
      address: _addressController.text,
    );

    setState(() {
      _isLoading = false;
      _nameController.text = '';
      _phoneController.text = '';
      _categoryController.text = '';
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Location saved successfully!'),
        ),
      );
      Navigator.pop(context);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const PoliticalGroupScreen()),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.50,
        height: MediaQuery.of(context).size.height * 0.45,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close)),
              ],
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(hintText: 'Address'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(hintText: 'Phone'),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(hintText: 'Category'),
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                height: 42,
                width: 180,
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
          ],
        ),
      ),
    );
  }
}
