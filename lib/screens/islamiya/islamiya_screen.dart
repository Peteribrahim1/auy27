import 'package:auy27/screens/islamiya/islamiya_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/color_constants.dart';
import '../../resources/custom_text.dart';
import '../../resources/font_constants.dart';
import '../../resources/styles.dart';
import '../categoy_screens.dart';
import 'add_islamiya.dart';

class IslamiyaScreen extends StatefulWidget {
  const IslamiyaScreen({super.key, required this.category});
  final String category;

  @override
  State<IslamiyaScreen> createState() => _IslamiyaScreenState();
}

class _IslamiyaScreenState extends State<IslamiyaScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> myList = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> groupDisplay = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('my categoriii ${widget.category}');
    _fetchData();
  }

  void _fetchData() async {
    setState(() {
      _isLoading = true;
      myList = [];
      groupDisplay = [];
    });
    final snap = await FirebaseFirestore.instance.collection('Islamiya').get();
    print(snap.docs[0]['name']);

    final snap2 = snap.docs
        .where((element) =>
            element["uid"] == FirebaseAuth.instance.currentUser?.uid)
        .toList();
    print('snap2 ${snap2.length}');
    print('snap ${snap.docs.length}');
    print('snap ${snap2[0]['name']}');
    myList = snap2.reversed.toList();
    groupDisplay.addAll(myList);
    print('my rapid ${myList[0]['name']}');
    setState(() {
      _isLoading = false;
    });
  }

  void searchItem(String query) {
    if (query.isEmpty) {
      groupDisplay = myList;
      setState(() {});
    } else {
      groupDisplay = myList
          .where((item) => item['name']
              .toString()
              .toLowerCase()
              .contains(query.toString().toLowerCase()))
          .toList();
      setState(() {});
      // for (int i = 0; i < myList.length; i++) {
      //   groupDisplay = myList
      //       .where((item) => item[i]['name']
      //           .toString()
      //           .toLowerCase()
      //           .contains(query.toString().toLowerCase()))
      //       .toList();
      //   print(query);
      //   // print(myList[i]['name']);
      //   setState(() {});
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 30, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //     builder: (context) => CategoryScreen(),
                          //   ),
                          // );
                        },
                        child: SvgPicture.asset(
                            'assets/images/arrowHeadBack.svg')),
                    const Spacer(),
                    const CustomText(
                      text: 'Islamiya',
                      textColor: black,
                      fontSize: 16,
                      fontWeight: mediumFont,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    searchItem(value);
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    filled: true,
                    counterText: "",
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color.fromRGBO(47, 79, 79, 1),
                    ),
                    contentPadding: const EdgeInsets.all(18),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(47, 79, 79, 1), width: 1),
                    ),
                    // hintStyle: TextStyle(color: Color.fromRGBO(47, 79, 79, 1)),
                  ),
                ),
              ),
              myList.length == 0
                  ? Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.40,
                          top: MediaQuery.of(context).size.height * 0.20),
                      child: Center(
                        child: Text('No record added yet. Add new group!'),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.70,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color.fromRGBO(47, 79, 79, 1),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: groupDisplay.length,
                              itemBuilder: (context, index) {
                                final data = groupDisplay[index];
                                print(data.reference.id.toString());
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                IslamiyaDetails(
                                                  ref: data.reference.id,
                                                  receive: data,
                                                  id: data['id'],
                                                  category: widget.category,
                                                )),
                                      );
                                      _fetchData();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: const Color.fromRGBO(
                                            249, 249, 249, 1),
                                      ),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              data['name'],
                                            ),
                                            subtitle: Text(
                                              data['address'],
                                            ),
                                            trailing: Text(
                                              'members ${data['members']}',
                                            ),
                                          ),
                                          const Divider(color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddIslamiya()),
                    );
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
                  child: const Text(
                    'New Group',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}