import 'package:auy27/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/color_constants.dart';
import '../resources/custom_text.dart';
import '../resources/font_constants.dart';
import '../resources/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences? loginData;
  String? username;

  bool _isLoading = false;
  int pol = 0;
  int resid = 0;
  int chur = 0;
  int masj = 0;
  int isla = 0;
  int acad = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
    fetchData();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData?.getString('username');
    });
  }

  void fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final snap_pol =
        await FirebaseFirestore.instance.collection('Political Group').get();

    final snap2_pol = snap_pol.docs.toList();
    // .where((element) =>
    //     element["uid"] == FirebaseAuth.instance.currentUser?.uid)
    // .toList();

    final snap_resi =
        await FirebaseFirestore.instance.collection('Residence').get();

    final snap2_resi = snap_resi.docs.toList();
    // .where((element) =>
    //     element["uid"] == FirebaseAuth.instance.currentUser?.uid)
    // .toList();

    final snap_isla =
        await FirebaseFirestore.instance.collection('Islamiya').get();

    final snap2_isla = snap_isla.docs.toList();
    // .where((element) =>
    //     element["uid"] == FirebaseAuth.instance.currentUser?.uid)
    // .toList();

    final snap_masj =
        await FirebaseFirestore.instance.collection('Masjid').get();

    final snap2_masj = snap_masj.docs.toList();
    // .where((element) =>
    //     element["uid"] == FirebaseAuth.instance.currentUser?.uid)
    // .toList();

    final snap_chur =
        await FirebaseFirestore.instance.collection('Church').get();

    final snap2_chur = snap_chur.docs.toList();
    // .where((element) =>
    //     element["uid"] == FirebaseAuth.instance.currentUser?.uid)
    // .toList();

    final snap_acad =
        await FirebaseFirestore.instance.collection('Academia').get();

    final snap2_acad = snap_acad.docs.toList();
    // .where((element) =>
    //     element["uid"] == FirebaseAuth.instance.currentUser?.uid)
    // .toList();

    pol = snap2_pol.length;
    resid = snap2_resi.length;
    isla = snap2_isla.length;
    masj = snap2_masj.length;
    acad = snap2_acad.length;
    chur = snap2_chur.length;

    print('number of itemss $pol');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Spacer(
                          flex: 4,
                        ),
                        CustomText(
                          text: 'DASHBOARD',
                          textColor: black,
                          fontSize: 16,
                          fontWeight: mediumFont,
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        InkWell(
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                              loginData?.setBool('login', true);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('You are logged out!'),
                                ),
                              );
                            },
                            child: Icon(Icons.power_settings_new)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      childAspectRatio: 1,
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromRGBO(47, 79, 79, 1),
                          ),
                          height: 210,
                          width: 170,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Islamiya',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: isla.toString(),
                                textColor: white,
                                fontSize: 26,
                                fontWeight: mediumFont,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromRGBO(47, 79, 79, 1),
                          ),
                          height: 210,
                          width: 170,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Masjid',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: masj.toString(),
                                textColor: white,
                                fontSize: 26,
                                fontWeight: mediumFont,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromRGBO(47, 79, 79, 1),
                          ),
                          height: 210,
                          width: 170,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Church',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: chur.toString(),
                                textColor: white,
                                fontSize: 26,
                                fontWeight: mediumFont,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromRGBO(47, 79, 79, 1),
                          ),
                          height: 210,
                          width: 170,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Academia',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: acad.toString(),
                                textColor: white,
                                fontSize: 26,
                                fontWeight: mediumFont,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromRGBO(47, 79, 79, 1),
                          ),
                          height: 210,
                          width: 170,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Political Groups',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: pol.toString(),
                                textColor: white,
                                fontSize: 26,
                                fontWeight: mediumFont,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromRGBO(47, 79, 79, 1),
                          ),
                          height: 210,
                          width: 170,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Residence',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: resid.toString(),
                                textColor: white,
                                fontSize: 26,
                                fontWeight: mediumFont,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    //  child: Text('signed in as $username'),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'signed in as ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                          TextSpan(
                            text: '$username',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(47, 79, 79, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
