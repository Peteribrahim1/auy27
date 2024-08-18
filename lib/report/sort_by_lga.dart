// import 'package:flutter/material.dart';
//
// import '../resources/color_constants.dart';
// import '../resources/custom_text.dart';
// import '../resources/font_constants.dart';
//
// class ReportLGA extends StatelessWidget {
//   const ReportLGA({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(
//                   top: 20, bottom: 30, left: 10, right: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const Spacer(),
//                   const CustomText(
//                     text: 'REPORT',
//                     textColor: black,
//                     fontSize: 16,
//                     fontWeight: mediumFont,
//                   ),
//                   const Spacer(),
//                 ],
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: const Color.fromRGBO(47, 79, 79, 1),
//                   ),
//                   child: const ListTile(
//                     title: CustomText(
//                       text: 'AKKO',
//                       textColor: white,
//                       fontSize: 16,
//                       fontWeight: mediumFont,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: const Color.fromRGBO(47, 79, 79, 1),
//                   ),
//                   child: const ListTile(
//                     title: CustomText(
//                       text: 'BALANGA',
//                       textColor: white,
//                       fontSize: 16,
//                       fontWeight: mediumFont,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Color.fromRGBO(47, 79, 79, 1),
//                   ),
//                   child: const ListTile(
//                     title: CustomText(
//                       text: 'BILLIRI',
//                       textColor: white,
//                       fontSize: 16,
//                       fontWeight: mediumFont,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: const Color.fromRGBO(47, 79, 79, 1),
//                   ),
//                   child: const ListTile(
//                     title: CustomText(
//                       text: 'DUKKU',
//                       textColor: white,
//                       fontSize: 16,
//                       fontWeight: mediumFont,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: const Color.fromRGBO(47, 79, 79, 1),
//                   ),
//                   child: const ListTile(
//                     title: CustomText(
//                       text: 'FUNAKAYE',
//                       textColor: white,
//                       fontSize: 16,
//                       fontWeight: mediumFont,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: const Color.fromRGBO(47, 79, 79, 1),
//                   ),
//                   child: const ListTile(
//                     title: CustomText(
//                       text: 'GOMBE',
//                       textColor: white,
//                       fontSize: 16,
//                       fontWeight: mediumFont,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: const Color.fromRGBO(47, 79, 79, 1),
//                   ),
//                   child: const ListTile(
//                     title: CustomText(
//                       text: 'KALTUNGO',
//                       textColor: white,
//                       fontSize: 16,
//                       fontWeight: mediumFont,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: const Color.fromRGBO(47, 79, 79, 1),
//                   ),
//                   child: const ListTile(
//                     title: CustomText(
//                       text: 'KWAMI',
//                       textColor: white,
//                       fontSize: 16,
//                       fontWeight: mediumFont,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: const Color.fromRGBO(47, 79, 79, 1),
//                   ),
//                   child: const ListTile(
//                     title: CustomText(
//                       text: 'NAFADA',
//                       textColor: white,
//                       fontSize: 16,
//                       fontWeight: mediumFont,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: const Color.fromRGBO(47, 79, 79, 1),
//                   ),
//                   child: const ListTile(
//                     title: CustomText(
//                       text: 'SHONGOM',
//                       textColor: white,
//                       fontSize: 16,
//                       fontWeight: mediumFont,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: const Color.fromRGBO(47, 79, 79, 1),
//                   ),
//                   child: const ListTile(
//                     title: CustomText(
//                       text: 'YAMALTU',
//                       textColor: white,
//                       fontSize: 16,
//                       fontWeight: mediumFont,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
