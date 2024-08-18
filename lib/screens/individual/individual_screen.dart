import 'package:auy27/screens/individual/add_individual.dart';
import 'package:auy27/screens/individual/individual_details.dart';
import 'package:auy27/screens/tabs_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../resources/color_constants.dart';
import '../../resources/custom_text.dart';
import '../../resources/font_constants.dart';

class IndividualScreen extends StatefulWidget {
  const IndividualScreen({super.key, required this.category});
  final String category;

  @override
  State<IndividualScreen> createState() => _IndividualScreenState();
}

class _IndividualScreenState extends State<IndividualScreen> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _myList = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _groupDisplay = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //   print('my categoriii ${widget.category}');
    _fetchData();
  }

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final snap =
        await FirebaseFirestore.instance.collection('Individual').get();

    final snap2 = snap.docs.toList();
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
                                // Navigator.pop(context);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TabsScreen(number: 1),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.arrow_back,
                              )),
                          const Spacer(),
                          const CustomText(
                            text: 'Individual',
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
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _groupDisplay.length,
                                    itemBuilder: (context, index) {
                                      final data = _groupDisplay[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () async {
                                            // print('my id is ${data.id}');
                                            // print(
                                            //     'my id is ${data.reference.id}');
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    IndividualDetails(
                                                  ref: data.reference.id,
                                                  receive: data,
                                                  id: data['id'],
                                                  category: widget.category,
                                                ),
                                              ),
                                            );
                                            // await showModalBottomSheet(
                                            //   context: context,
                                            //   builder: (context) =>
                                            //       SingleChildScrollView(
                                            //     padding:
                                            //         const EdgeInsets.all(20),
                                            //     child: Column(
                                            //       crossAxisAlignment:
                                            //           CrossAxisAlignment.start,
                                            //       children: [
                                            //         Row(
                                            //           children: [
                                            //             InkWell(
                                            //                 onTap: () {
                                            //                   Navigator.of(
                                            //                           context)
                                            //                       .pop();
                                            //                 },
                                            //                 child: const Icon(
                                            //                     Icons
                                            //                         .arrow_back)),
                                            //           ],
                                            //         ),
                                            //         const SizedBox(height: 15),
                                            //         const Center(
                                            //           child: Text(
                                            //             'Admin Panel',
                                            //             style: Styles
                                            //                 .headerTextStyle,
                                            //           ),
                                            //         ),
                                            //         const SizedBox(height: 25),
                                            //         const Text(
                                            //           'Only Admin Can View This Page',
                                            //           style:
                                            //               Styles.fieldTextStyle,
                                            //         ),
                                            //         const SizedBox(height: 5),
                                            //         TextField(
                                            //           obscureText: true,
                                            //           keyboardType:
                                            //               TextInputType.number,
                                            //           controller:
                                            //               _passwordController,
                                            //           decoration:
                                            //               InputDecoration(
                                            //             filled: true,
                                            //             fillColor: Colors.white,
                                            //             prefixIcon: const Icon(
                                            //               Icons.password,
                                            //             ),
                                            //             contentPadding:
                                            //                 const EdgeInsets
                                            //                     .all(18),
                                            //             hintText:
                                            //                 'admin access code',
                                            //             border:
                                            //                 OutlineInputBorder(
                                            //               borderRadius:
                                            //                   BorderRadius
                                            //                       .circular(15),
                                            //             ),
                                            //             enabledBorder: OutlineInputBorder(
                                            //                 borderRadius:
                                            //                     BorderRadius
                                            //                         .circular(
                                            //                             15),
                                            //                 borderSide:
                                            //                     const BorderSide(
                                            //                         color: Color
                                            //                             .fromRGBO(
                                            //                                 20,
                                            //                                 10,
                                            //                                 38,
                                            //                                 1),
                                            //                         width: 1)),
                                            //             hintStyle: Styles
                                            //                 .hintTextStyle,
                                            //           ),
                                            //         ),
                                            //         const SizedBox(height: 35),
                                            //         Center(
                                            //           child: SizedBox(
                                            //             height: 52,
                                            //             width: 280,
                                            //             child: ElevatedButton(
                                            //               onPressed: () {
                                            //                 if (_passwordController
                                            //                     .text
                                            //                     .isNotEmpty) {
                                            //                   if (_passwordController
                                            //                           .text ==
                                            //                       '1234') {
                                            //                     setState(() {
                                            //                       _passwordController
                                            //                           .text = '';
                                            //                     });
                                            //                     Navigator.of(
                                            //                             context)
                                            //                         .pushReplacement(
                                            //                       MaterialPageRoute(
                                            //                         builder:
                                            //                             (context) =>
                                            //                                 IndividualDetails(
                                            //                           ref: data
                                            //                               .reference
                                            //                               .id,
                                            //                           receive:
                                            //                               data,
                                            //                           id: data[
                                            //                               'id'],
                                            //                           category:
                                            //                               widget
                                            //                                   .category,
                                            //                         ),
                                            //                       ),
                                            //                     );
                                            //                   } else {
                                            //                     setState(() {
                                            //                       _passwordController
                                            //                           .text = '';
                                            //                     });
                                            //                     Navigator.of(
                                            //                             context)
                                            //                         .pop();
                                            //                     ScaffoldMessenger.of(
                                            //                             context)
                                            //                         .showSnackBar(
                                            //                       const SnackBar(
                                            //                         backgroundColor:
                                            //                             Colors
                                            //                                 .red,
                                            //                         content: Text(
                                            //                             'Incorrect admin access code!'),
                                            //                       ),
                                            //                     );
                                            //                   }
                                            //                 } else {
                                            //                   Navigator.of(
                                            //                           context)
                                            //                       .pop();
                                            //                   ScaffoldMessenger
                                            //                           .of(context)
                                            //                       .showSnackBar(
                                            //                     const SnackBar(
                                            //                       backgroundColor:
                                            //                           Colors
                                            //                               .red,
                                            //                       content: Text(
                                            //                           'Please enter the access code!'),
                                            //                     ),
                                            //                   );
                                            //                 }
                                            //               },
                                            //               style: ButtonStyle(
                                            //                   backgroundColor:
                                            //                       MaterialStateProperty
                                            //                           .all(
                                            //                     const Color
                                            //                         .fromRGBO(
                                            //                         47,
                                            //                         79,
                                            //                         79,
                                            //                         1),
                                            //                   ),
                                            //                   shape: MaterialStateProperty.all<
                                            //                           RoundedRectangleBorder>(
                                            //                       RoundedRectangleBorder(
                                            //                     borderRadius:
                                            //                         BorderRadius
                                            //                             .circular(
                                            //                                 10),
                                            //                   ))),
                                            //               child: _isLoading
                                            //                   ? const Center(
                                            //                       child:
                                            //                           CircularProgressIndicator(
                                            //                         color: Colors
                                            //                             .white,
                                            //                       ),
                                            //                     )
                                            //                   : const Text(
                                            //                       'Login',
                                            //                       style: Styles
                                            //                           .buttonTextStyle,
                                            //                     ),
                                            //             ),
                                            //           ),
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // );
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
                                builder: (context) => AddIndividual()),
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
