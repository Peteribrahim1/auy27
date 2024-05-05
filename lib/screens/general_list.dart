import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../resources/styles.dart';

class GeneralList extends StatefulWidget {
  const GeneralList({super.key});

  @override
  State<GeneralList> createState() => _GeneralListState();
}

class _GeneralListState extends State<GeneralList> {
  bool _isLoading = false;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _myList = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _groupDisplay = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final snap =
        await FirebaseFirestore.instance.collection('General Map').get();

    final snap2 = snap.docs.toList();

    _myList = snap2.reversed.toList();
    _groupDisplay.addAll(_myList);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        title: Text(
          'General Map List',
          style: Styles.appBarTextStyle,
        ),
        backgroundColor: const Color.fromRGBO(47, 79, 79, 1),
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _groupDisplay.length,
                itemBuilder: (context, index) {
                  final data = _groupDisplay[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromRGBO(249, 249, 249, 1),
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
                              'phone ${data['phone']}',
                            ),
                          ),
                          const Divider(color: Colors.grey),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
