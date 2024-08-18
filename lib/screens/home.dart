import 'package:auy27/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resources/color_constants.dart';
import '../resources/custom_text.dart';
import '../resources/font_constants.dart';

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
  int individ = 0;
  // total
  int total_akko = 0;
  int total_balanga = 0;
  int total_billiri = 0;
  int total_dukku = 0;
  int total_funakaye = 0;
  int total_gombe = 0;
  int total_kaltungo = 0;
  int total_kwami = 0;
  int total_nafada = 0;
  int total_shongom = 0;
  int total_yamaltu = 0;
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

    try {
      // Fetch all collections in parallel
      final futures = [
        FirebaseFirestore.instance.collection('Political Group').get(),
        FirebaseFirestore.instance.collection('Residence').get(),
        FirebaseFirestore.instance.collection('Islamiya').get(),
        FirebaseFirestore.instance.collection('Masjid').get(),
        FirebaseFirestore.instance.collection('Church').get(),
        FirebaseFirestore.instance.collection('Academia').get(),
        FirebaseFirestore.instance.collection('Individual').get(),
      ];

      final results = await Future.wait(futures);

      // Assign results to respective variables
      final snap2_pol = results[0].docs.toList();
      final snap2_resi = results[1].docs.toList();
      final snap2_isla = results[2].docs.toList();
      final snap2_masj = results[3].docs.toList();
      final snap2_chur = results[4].docs.toList();
      final snap2_acad = results[5].docs.toList();
      final snap2_indi = results[6].docs.toList();

      // Count the number of documents in each collection
      setState(() {
        pol = snap2_pol.length;
        resid = snap2_resi.length;
        isla = snap2_isla.length;
        masj = snap2_masj.length;
        acad = snap2_acad.length;
        chur = snap2_chur.length;
        individ = snap2_indi.length;
      });

      // Call the function to count documents by LGA
      await fetchAndCountDocuments(results);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      // Handle any errors here
      setState(() {
        _isLoading = false;
      });
      print("Error fetching data: $e");
    }
  }

  Future<void> fetchAndCountDocuments(List<QuerySnapshot> results) async {
    // Map to hold the counts for each LGA
    final Map<String, int> lgaCounts = {
      'Akko': 0,
      'Balanga': 0,
      'Billiri': 0,
      'Dukku': 0,
      'Funakaye': 0,
      'Gombe': 0,
      'Kaltungo': 0,
      'Kwami': 0,
      'Nafada': 0,
      'Shongom': 0,
      'Yamaltu': 0,
    };

    // Iterate over each collection's documents
    for (var result in results) {
      for (var doc in result.docs) {
        final lga = doc['lga'];
        if (lgaCounts.containsKey(lga)) {
          lgaCounts[lga] = lgaCounts[lga]! + 1;
        }
      }
    }

    // Extract total counts for each LGA
    total_akko = lgaCounts['Akko']!;
    total_balanga = lgaCounts['Balanga']!;
    total_billiri = lgaCounts['Billiri']!;
    total_dukku = lgaCounts['Dukku']!;
    total_funakaye = lgaCounts['Funakaye']!;
    total_gombe = lgaCounts['Gombe']!;
    total_kaltungo = lgaCounts['Kaltungo']!;
    total_kwami = lgaCounts['Kwami']!;
    total_nafada = lgaCounts['Nafada']!;
    total_shongom = lgaCounts['Shongom']!;
    total_yamaltu = lgaCounts['Yamaltu']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.of(context).push(
                        //       MaterialPageRoute(
                        //         builder: (context) => ReportLGA(),
                        //       ),
                        //     );
                        //   },
                        //   child: Icon(Icons.report),
                        // ),
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
                      crossAxisCount: 3,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromRGBO(77, 69, 69, 1),
                          ),
                          height: 180,
                          width: 140,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Akko',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: total_akko.toString(),
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
                            color: const Color.fromRGBO(77, 69, 69, 1),
                          ),
                          height: 180,
                          width: 140,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Balanga',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: total_balanga.toString(),
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
                            color: const Color.fromRGBO(77, 69, 69, 1),
                          ),
                          height: 180,
                          width: 140,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Billiri',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: total_billiri.toString(),
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
                            color: const Color.fromRGBO(77, 69, 69, 1),
                          ),
                          height: 180,
                          width: 140,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Dukku',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: total_dukku.toString(),
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
                            color: const Color.fromRGBO(77, 69, 69, 1),
                          ),
                          height: 180,
                          width: 140,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Funakaye',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: total_funakaye.toString(),
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
                            color: const Color.fromRGBO(77, 69, 69, 1),
                          ),
                          height: 180,
                          width: 140,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Gombe',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: total_gombe.toString(),
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
                            color: const Color.fromRGBO(77, 69, 69, 1),
                          ),
                          height: 180,
                          width: 140,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Kaltungo',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: total_kaltungo.toString(),
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
                            color: const Color.fromRGBO(77, 69, 69, 1),
                          ),
                          height: 180,
                          width: 140,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Kwami',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: total_kwami.toString(),
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
                            color: const Color.fromRGBO(77, 69, 69, 1),
                          ),
                          height: 180,
                          width: 140,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Nafada',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: total_nafada.toString(),
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
                            color: const Color.fromRGBO(77, 69, 69, 1),
                          ),
                          height: 180,
                          width: 140,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Shongom',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: total_shongom.toString(),
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
                            color: const Color.fromRGBO(77, 69, 69, 1),
                          ),
                          height: 180,
                          width: 140,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Yamaltu',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: total_yamaltu.toString(),
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
                          height: 180,
                          width: 140,
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
                          height: 180,
                          width: 140,
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
                          height: 180,
                          width: 140,
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
                          height: 180,
                          width: 140,
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
                          height: 180,
                          width: 140,
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
                          height: 180,
                          width: 140,
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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromRGBO(47, 79, 79, 1),
                          ),
                          height: 180,
                          width: 140,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Individuals',
                                textColor: white,
                                fontSize: 16,
                                fontWeight: mediumFont,
                              ),
                              CustomText(
                                text: individ.toString(),
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
