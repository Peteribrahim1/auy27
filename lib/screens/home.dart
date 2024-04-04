import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../resources/color_constants.dart';
import '../resources/custom_text.dart';
import '../resources/font_constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    fetchData();
  }

  void fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final snap_pol =
        await FirebaseFirestore.instance.collection('Political Group').get();

    final snap2_pol = snap_pol.docs
        .where((element) =>
            element["uid"] == FirebaseAuth.instance.currentUser?.uid)
        .toList();

    final snap_resi =
        await FirebaseFirestore.instance.collection('Residence').get();

    final snap2_resi = snap_resi.docs
        .where((element) =>
            element["uid"] == FirebaseAuth.instance.currentUser?.uid)
        .toList();

    final snap_isla =
        await FirebaseFirestore.instance.collection('Islamiya').get();

    final snap2_isla = snap_isla.docs
        .where((element) =>
            element["uid"] == FirebaseAuth.instance.currentUser?.uid)
        .toList();

    final snap_masj =
        await FirebaseFirestore.instance.collection('Masjid').get();

    final snap2_masj = snap_masj.docs
        .where((element) =>
            element["uid"] == FirebaseAuth.instance.currentUser?.uid)
        .toList();

    final snap_chur =
        await FirebaseFirestore.instance.collection('Church').get();

    final snap2_chur = snap_chur.docs
        .where((element) =>
            element["uid"] == FirebaseAuth.instance.currentUser?.uid)
        .toList();

    final snap_acad =
        await FirebaseFirestore.instance.collection('Academia').get();

    final snap2_acad = snap_acad.docs
        .where((element) =>
            element["uid"] == FirebaseAuth.instance.currentUser?.uid)
        .toList();

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
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Spacer(),
                        const CustomText(
                          text: 'DASHBOARD',
                          textColor: black,
                          fontSize: 16,
                          fontWeight: mediumFont,
                        ),
                        const Spacer(),
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
                  )
                ],
              ),
      ),
    );
  }
}
