import 'package:auy27/screens/political_groups/add_political_group.dart';
import 'package:auy27/screens/political_groups/political_group_details.dart';
import 'package:auy27/screens/tabs_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/color_constants.dart';
import '../../resources/custom_text.dart';
import '../../resources/font_constants.dart';

class PoliticalGroupScreen extends StatefulWidget {
  const PoliticalGroupScreen({super.key, required this.category});
  final String category;
  @override
  State<PoliticalGroupScreen> createState() => _PoliticalGroupScreenState();
}

class _PoliticalGroupScreenState extends State<PoliticalGroupScreen> {
  final TextEditingController searchController = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _groupDisplay = [];
  bool _isLoading = false;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _myList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    print(widget.category);
    setState(() {
      _isLoading = true;
    });
    final snap =
        await FirebaseFirestore.instance.collection(widget.category).get();
    //  print(snap.docs[0]['name']);

    final snap2 = snap.docs.toList();
    // .where((element) =>
    //     element["uid"] == FirebaseAuth.instance.currentUser?.uid)
    // .toList();
    _myList = snap2.reversed.toList();
    _groupDisplay.addAll(_myList);
    setState(() {
      _isLoading = false;
    });
  }

  void searchItem(String query) {
    if (query.isEmpty) {
      _groupDisplay = _myList;
      setState(() {});
    } else {
      _groupDisplay = _myList
          .where((item) => item['name']
              .toString()
              .toLowerCase()
              .contains(query.toString().toLowerCase()))
          .toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : SingleChildScrollView(
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TabsScreen(number: 1),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.arrow_back,
                              )
                              // SvgPicture.asset(
                              //     'assets/images/arrowHeadBack.svg'),
                              ),
                          const Spacer(),
                          const CustomText(
                            text: 'Political Group',
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
                    _groupDisplay.length == 0
                        ? Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.40,
                                top: MediaQuery.of(context).size.height * 0.20),
                            child: Center(
                              child:
                                  Text('No record added yet. Add new group!'),
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.65,
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
                                : _myList.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 300, top: 200),
                                        child: Center(
                                          child: Text(
                                              'No record saved yet. Add new group'),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: _groupDisplay.length,
                                        itemBuilder: (context, index) {
                                          final data = _groupDisplay[index];
                                          // print(data.reference.id.toString());
                                          // print(_myList.length);
                                          // // print(data.id);
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () async {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PoliticalGroupDetails(
                                                      ref: data.reference.id,
                                                      receive: data,
                                                      id: data['id'],
                                                      category: widget.category,
                                                      fire_id: data.id,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: const Color.fromRGBO(
                                                      249, 249, 249, 1),
                                                ),
                                                child: ListTile(
                                                  title: Text(
                                                    data['name'],
                                                  ),
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
                                builder: (context) => AddPoliticalGroup()),
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
                          'Add New Record',
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
