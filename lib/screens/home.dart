import 'package:auy27/report/sort_by_lga.dart';
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
    final snap_pol =
        await FirebaseFirestore.instance.collection('Political Group').get();

    final snap2_pol = snap_pol.docs.toList();
    // .where((element) =>
    //     element["uid"] == FirebaseAuth.instance.currentUser?.uid)
    // .toList();

    final snap_resi =
        await FirebaseFirestore.instance.collection('Residence').get();

    final snap2_resi = snap_resi.docs.toList();

    final snap_isla =
        await FirebaseFirestore.instance.collection('Islamiya').get();

    final snap2_isla = snap_isla.docs.toList();

    final snap_masj =
        await FirebaseFirestore.instance.collection('Masjid').get();

    final snap2_masj = snap_masj.docs.toList();

    final snap_chur =
        await FirebaseFirestore.instance.collection('Church').get();

    final snap2_chur = snap_chur.docs.toList();

    final snap_acad =
        await FirebaseFirestore.instance.collection('Academia').get();

    final snap2_acad = snap_acad.docs.toList();

    final snap_indi =
        await FirebaseFirestore.instance.collection('Individual').get();

    final snap2_indi = snap_indi.docs.toList();

    pol = snap2_pol.length;
    resid = snap2_resi.length;
    isla = snap2_isla.length;
    masj = snap2_masj.length;
    acad = snap2_acad.length;
    chur = snap2_chur.length;
    individ = snap2_indi.length;

    //////// academia
    final aca = await FirebaseFirestore.instance.collection('Academia').get();

    final aca_akko =
        aca.docs.where((element) => element["lga"] == 'Akko').toList();
    // print('here is one Akko ${aca_akko.length}');

    final aca_balanga =
        aca.docs.where((element) => element["lga"] == 'Balanga').toList();

    final aca_br =
        aca.docs.where((element) => element["lga"] == 'Billiri').toList();

    final aca_dukku =
        aca.docs.where((element) => element["lga"] == 'Dukku').toList();

    final aca_fun =
        aca.docs.where((element) => element["lga"] == 'Funakaye').toList();

    final aca_gom =
        aca.docs.where((element) => element["lga"] == 'Gombe').toList();

    final aca_kt =
        aca.docs.where((element) => element["lga"] == 'Kaltungo').toList();

    final aca_kwami =
        aca.docs.where((element) => element["lga"] == 'Kwami').toList();

    final aca_naf =
        aca.docs.where((element) => element["lga"] == 'Nafada').toList();

    final aca_shongom =
        aca.docs.where((element) => element["lga"] == 'Shongom').toList();

    final aca_yam =
        aca.docs.where((element) => element["lga"] == 'Yamaltu').toList();

    //////// church
    final ch = await FirebaseFirestore.instance.collection('Church').get();

    final ch_akko =
        ch.docs.where((element) => element["lga"] == 'Akko').toList();

    final ch_balanga =
        ch.docs.where((element) => element["lga"] == 'Balanga').toList();

    final ch_br =
        ch.docs.where((element) => element["lga"] == 'Billiri').toList();

    final ch_dukku =
        ch.docs.where((element) => element["lga"] == 'Dukku').toList();

    final ch_fun =
        ch.docs.where((element) => element["lga"] == 'Funakaye').toList();

    final ch_gom =
        ch.docs.where((element) => element["lga"] == 'Gombe').toList();

    final ch_kt =
        ch.docs.where((element) => element["lga"] == 'Kaltungo').toList();

    final ch_kwami =
        ch.docs.where((element) => element["lga"] == 'Kwami').toList();

    final ch_naf =
        ch.docs.where((element) => element["lga"] == 'Nafada').toList();

    final ch_shongom =
        ch.docs.where((element) => element["lga"] == 'Shongom').toList();

    final ch_yam =
        ch.docs.where((element) => element["lga"] == 'Yamaltu').toList();

    //////// islamiya
    final isl = await FirebaseFirestore.instance.collection('Islamiya').get();

    final isl_akko =
        isl.docs.where((element) => element["lga"] == 'Akko').toList();

    final isl_balanga =
        isl.docs.where((element) => element["lga"] == 'Balanga').toList();

    final isl_br =
        isl.docs.where((element) => element["lga"] == 'Billiri').toList();

    final isl_dukku =
        isl.docs.where((element) => element["lga"] == 'Dukku').toList();

    final isl_fun =
        isl.docs.where((element) => element["lga"] == 'Funakaye').toList();

    final isl_gom =
        isl.docs.where((element) => element["lga"] == 'Gombe').toList();

    final isl_kt =
        isl.docs.where((element) => element["lga"] == 'Kaltungo').toList();

    final isl_kwami =
        isl.docs.where((element) => element["lga"] == 'Kwami').toList();

    final isl_naf =
        isl.docs.where((element) => element["lga"] == 'Nafada').toList();

    final isl_shongom =
        isl.docs.where((element) => element["lga"] == 'Shongom').toList();

    final isl_yam =
        isl.docs.where((element) => element["lga"] == 'Yamaltu').toList();

    //////// mas
    final mas = await FirebaseFirestore.instance.collection('Masjid').get();

    final mas_akko =
        mas.docs.where((element) => element["lga"] == 'Akko').toList();

    final mas_balanga =
        mas.docs.where((element) => element["lga"] == 'Balanga').toList();

    final mas_br =
        mas.docs.where((element) => element["lga"] == 'Billiri').toList();

    final mas_dukku =
        mas.docs.where((element) => element["lga"] == 'Dukku').toList();

    final mas_fun =
        mas.docs.where((element) => element["lga"] == 'Funakaye').toList();

    final mas_gom =
        mas.docs.where((element) => element["lga"] == 'Gombe').toList();

    final mas_kt =
        mas.docs.where((element) => element["lga"] == 'Kaltungo').toList();

    final mas_kwami =
        mas.docs.where((element) => element["lga"] == 'Kwami').toList();

    final mas_naf =
        mas.docs.where((element) => element["lga"] == 'Nafada').toList();

    final mas_shongom =
        mas.docs.where((element) => element["lga"] == 'Shongom').toList();

    final mas_yam =
        mas.docs.where((element) => element["lga"] == 'Yamaltu').toList();

    //////// political
    final po =
        await FirebaseFirestore.instance.collection('Political Group').get();

    final po_akko =
        po.docs.where((element) => element["lga"] == 'Akko').toList();

    final po_balanga =
        po.docs.where((element) => element["lga"] == 'Balanga').toList();

    final po_br =
        po.docs.where((element) => element["lga"] == 'Billiri').toList();

    final po_dukku =
        po.docs.where((element) => element["lga"] == 'Dukku').toList();

    final po_fun =
        po.docs.where((element) => element["lga"] == 'Funakaye').toList();

    final po_gom =
        po.docs.where((element) => element["lga"] == 'Gombe').toList();

    final po_kt =
        po.docs.where((element) => element["lga"] == 'Kaltungo').toList();

    final po_kwami =
        po.docs.where((element) => element["lga"] == 'Kwami').toList();

    final po_naf =
        po.docs.where((element) => element["lga"] == 'Nafada').toList();

    final po_shongom =
        po.docs.where((element) => element["lga"] == 'Shongom').toList();

    final po_yam =
        po.docs.where((element) => element["lga"] == 'Yamaltu').toList();

    //////// residence
    final re = await FirebaseFirestore.instance.collection('Residence').get();

    final re_akko =
        re.docs.where((element) => element["lga"] == 'Akko').toList();

    final re_balanga =
        re.docs.where((element) => element["lga"] == 'Balanga').toList();

    final re_br =
        re.docs.where((element) => element["lga"] == 'Billiri').toList();

    final re_dukku =
        re.docs.where((element) => element["lga"] == 'Dukku').toList();

    final re_fun =
        re.docs.where((element) => element["lga"] == 'Funakaye').toList();

    final re_gom =
        re.docs.where((element) => element["lga"] == 'Gombe').toList();

    final re_kt =
        re.docs.where((element) => element["lga"] == 'Kaltungo').toList();

    final re_kwami =
        re.docs.where((element) => element["lga"] == 'Kwami').toList();

    final re_naf =
        re.docs.where((element) => element["lga"] == 'Nafada').toList();

    final re_shongom =
        re.docs.where((element) => element["lga"] == 'Shongom').toList();

    final re_yam =
        re.docs.where((element) => element["lga"] == 'Yamaltu').toList();

    //////// individual
    final ind = await FirebaseFirestore.instance.collection('Individual').get();

    final ind_akko =
        ind.docs.where((element) => element["lga"] == 'Akko').toList();

    final ind_balanga =
        ind.docs.where((element) => element["lga"] == 'Balanga').toList();

    final ind_br =
        ind.docs.where((element) => element["lga"] == 'Billiri').toList();

    final ind_dukku =
        ind.docs.where((element) => element["lga"] == 'Dukku').toList();

    final ind_fun =
        ind.docs.where((element) => element["lga"] == 'Funakaye').toList();

    final ind_gom =
        ind.docs.where((element) => element["lga"] == 'Gombe').toList();

    final ind_kt =
        ind.docs.where((element) => element["lga"] == 'Kaltungo').toList();

    final ind_kwami =
        ind.docs.where((element) => element["lga"] == 'Kwami').toList();

    final ind_naf =
        ind.docs.where((element) => element["lga"] == 'Nafada').toList();

    final ind_shongom =
        ind.docs.where((element) => element["lga"] == 'Shongom').toList();

    final ind_yam =
        ind.docs.where((element) => element["lga"] == 'Yamaltu').toList();

    total_akko = aca_akko.length +
        ch_akko.length +
        isl_akko.length +
        mas_akko.length +
        po_akko.length +
        re_akko.length +
        ind_akko.length;

    total_balanga = aca_balanga.length +
        ch_balanga.length +
        isl_balanga.length +
        mas_balanga.length +
        po_balanga.length +
        re_balanga.length +
        ind_balanga.length;

    total_billiri = aca_br.length +
        ch_br.length +
        isl_br.length +
        mas_br.length +
        po_br.length +
        re_br.length +
        ind_br.length;

    total_dukku = aca_dukku.length +
        ch_dukku.length +
        isl_dukku.length +
        mas_dukku.length +
        po_dukku.length +
        re_dukku.length +
        ind_dukku.length;

    total_funakaye = aca_fun.length +
        ch_fun.length +
        isl_fun.length +
        mas_fun.length +
        po_fun.length +
        re_fun.length +
        ind_fun.length;

    total_gombe = aca_gom.length +
        ch_gom.length +
        isl_gom.length +
        mas_gom.length +
        po_gom.length +
        re_gom.length +
        ind_gom.length;

    total_kaltungo = aca_kt.length +
        ch_kt.length +
        isl_kt.length +
        mas_kt.length +
        po_kt.length +
        re_kt.length +
        ind_kt.length;

    total_kwami = aca_kwami.length +
        ch_kwami.length +
        isl_kwami.length +
        mas_kwami.length +
        po_kwami.length +
        re_kwami.length +
        ind_kwami.length;

    total_nafada = aca_naf.length +
        ch_naf.length +
        isl_naf.length +
        mas_naf.length +
        po_naf.length +
        re_naf.length +
        ind_naf.length;

    total_shongom = aca_shongom.length +
        ch_shongom.length +
        isl_shongom.length +
        mas_shongom.length +
        po_shongom.length +
        re_shongom.length +
        ind_shongom.length;

    total_yamaltu = aca_yam.length +
        ch_yam.length +
        isl_yam.length +
        mas_yam.length +
        po_yam.length +
        re_yam.length +
        ind_yam.length;

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
