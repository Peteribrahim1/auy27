import 'package:auy27/screens/church/church_screen.dart';
import 'package:auy27/screens/individual/individual_screen.dart';
import 'package:auy27/screens/islamiya/islamiya_screen.dart';
import 'package:auy27/screens/political_groups/political_group_screen.dart';
import 'package:auy27/screens/residence/residence_screen.dart';
import 'package:flutter/material.dart';

import '../resources/color_constants.dart';
import '../resources/custom_text.dart';
import '../resources/font_constants.dart';
import 'academia/academia_screen.dart';
import 'masjid/masjid_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 30, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const CustomText(
                      text: 'CATEGORIES',
                      textColor: black,
                      fontSize: 16,
                      fontWeight: mediumFont,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const IslamiyaScreen(
                              category: 'Islamiya',
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromRGBO(47, 79, 79, 1),
                    ),
                    child: const ListTile(
                      title: CustomText(
                        text: 'Islamiya',
                        textColor: white,
                        fontSize: 16,
                        fontWeight: mediumFont,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MasjidScreen(
                              category: 'Masjid',
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromRGBO(47, 79, 79, 1),
                    ),
                    child: const ListTile(
                      title: CustomText(
                        text: 'Masjid',
                        textColor: white,
                        fontSize: 16,
                        fontWeight: mediumFont,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChurchScreen(
                              category: 'Church',
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromRGBO(47, 79, 79, 1),
                    ),
                    child: const ListTile(
                      title: CustomText(
                        text: 'Church',
                        textColor: white,
                        fontSize: 16,
                        fontWeight: mediumFont,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AcademiaScreen(
                              category: 'Academia',
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromRGBO(47, 79, 79, 1),
                    ),
                    child: const ListTile(
                      title: CustomText(
                        text: 'Academia',
                        textColor: white,
                        fontSize: 16,
                        fontWeight: mediumFont,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PoliticalGroupScreen(
                              category: 'Political Group',
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromRGBO(47, 79, 79, 1),
                    ),
                    child: const ListTile(
                      title: CustomText(
                        text: 'Political Groups',
                        textColor: white,
                        fontSize: 16,
                        fontWeight: mediumFont,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResidenceScreen(
                              category: 'Residence',
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromRGBO(47, 79, 79, 1),
                    ),
                    child: const ListTile(
                      title: CustomText(
                        text: 'Residence',
                        textColor: white,
                        fontSize: 16,
                        fontWeight: mediumFont,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const IndividualScreen(
                              category: 'Individual',
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromRGBO(47, 79, 79, 1),
                    ),
                    child: const ListTile(
                      title: CustomText(
                        text: 'Individual',
                        textColor: white,
                        fontSize: 16,
                        fontWeight: mediumFont,
                      ),
                    ),
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
