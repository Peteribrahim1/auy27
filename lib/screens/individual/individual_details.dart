import 'package:auy27/screens/individual/edit_individual.dart';
import 'package:auy27/screens/individual/individual_screen.dart';
import 'package:auy27/screens/mark_point_map_page.dart';
import 'package:auy27/screens/view_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../resources/color_constants.dart';
import '../../resources/custom_text.dart';
import '../../resources/font_constants.dart';
import '../../resources/styles.dart';

class IndividualDetails extends StatefulWidget {
  IndividualDetails({
    super.key,
    required this.ref,
    required this.receive,
    required this.id,
    required this.category,
  });
  final String ref;
  final String id;
  final String category;
  final QueryDocumentSnapshot<Map<String, dynamic>> receive;

  @override
  State<IndividualDetails> createState() => _IndividualDetailsState();
}

class _IndividualDetailsState extends State<IndividualDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print('print ref o ${widget.ref}');
    // print(widget.receive['photoUrl']);
  }

  bool _isLoading = false;

  QueryDocumentSnapshot<Map<String, dynamic>>? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Individual Details Screen',
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
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.70,
              width: double.infinity,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: widget.receive['photoUrl'] != null &&
                              widget.receive['photoUrl'].isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: widget.receive['photoUrl'],
                              height: 200,
                              width: double.infinity,
                              key: UniqueKey(),
                              fit: BoxFit.cover,
                              maxHeightDiskCache: 200,
                              placeholder: (context, url) =>
                                  CupertinoActivityIndicator(
                                color: Color.fromRGBO(47, 79, 79, 1),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Text(
                                  'Some error occurred',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                'No Image uploaded',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Name',
                        textColor: black,
                        fontWeight: mediumFont,
                      ),
                      CustomText(
                        text: widget.receive['name'],
                        textColor: const Color.fromRGBO(47, 79, 79, 1),
                        fontWeight: mediumFont,
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Address',
                        textColor: black,
                        fontWeight: mediumFont,
                      ),
                      CustomText(
                        text: widget.receive['address'],
                        textColor: const Color.fromRGBO(47, 79, 79, 1),
                        fontWeight: mediumFont,
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Phone',
                        textColor: black,
                        fontWeight: mediumFont,
                      ),
                      CustomText(
                        text: widget.receive['phone'],
                        textColor: const Color.fromRGBO(47, 79, 79, 1),
                        fontWeight: mediumFont,
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Status',
                        textColor: black,
                        fontWeight: mediumFont,
                      ),
                      CustomText(
                        text: widget.receive['status'],
                        textColor: const Color.fromRGBO(47, 79, 79, 1),
                        fontWeight: mediumFont,
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'NIN',
                        textColor: black,
                        fontWeight: mediumFont,
                      ),
                      CustomText(
                        text: widget.receive['nin'],
                        textColor: const Color.fromRGBO(47, 79, 79, 1),
                        fontWeight: mediumFont,
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'BVN',
                        textColor: black,
                        fontWeight: mediumFont,
                      ),
                      CustomText(
                        text: widget.receive['bvn'],
                        textColor: const Color.fromRGBO(47, 79, 79, 1),
                        fontWeight: mediumFont,
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Voter Card',
                        textColor: black,
                        fontWeight: mediumFont,
                      ),
                      CustomText(
                        text: widget.receive['voter'],
                        textColor: const Color.fromRGBO(47, 79, 79, 1),
                        fontWeight: mediumFont,
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'LGA',
                        textColor: black,
                        fontWeight: mediumFont,
                      ),
                      CustomText(
                        text: widget.receive['lga'],
                        textColor: const Color.fromRGBO(47, 79, 79, 1),
                        fontWeight: mediumFont,
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Ward',
                        textColor: black,
                        fontWeight: mediumFont,
                      ),
                      CustomText(
                        text: widget.receive['ward'],
                        textColor: const Color.fromRGBO(47, 79, 79, 1),
                        fontWeight: mediumFont,
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'PU',
                        textColor: black,
                        fontWeight: mediumFont,
                      ),
                      CustomText(
                        text: widget.receive['polls'],
                        textColor: const Color.fromRGBO(47, 79, 79, 1),
                        fontWeight: mediumFont,
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditIndividual(
                                    fire_id: widget.ref,
                                    data: widget.receive,
                                  ),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.update,
                              color: Color.fromRGBO(47, 79, 79, 1),
                              size: 40,
                            ),
                          ),
                          Text('Edit'),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              await FirebaseFirestore.instance
                                  .collection('Individual')
                                  .doc(widget.ref)
                                  .delete();
                              setState(() {
                                _isLoading = false;
                              });
                              //Navigator.pop(context);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      IndividualScreen(category: 'Individual'),
                                ),
                              );
                            },
                            child: _isLoading
                                ? CircularProgressIndicator()
                                : Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                          ),
                          Text('Delete'),
                        ],
                      ),
                    ],
                  ),
                  // const SizedBox(height: 40),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MarkPointMapPage(
                                ref: widget.ref,
                                category: widget.category,
                                phone: widget.receive['phone'],
                                name: widget.receive['name'],
                                address: widget.receive['address']),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(47, 79, 79, 1),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Mark a Point',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewRoute(
                                    category: widget.category,
                                    id: widget.id,
                                  )),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(47, 79, 79, 1),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        'View Route',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
