// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../styles/styles.dart';
//
// class Item extends StatefulWidget {
//   final dynamic itemVal;
//   const Item({Key? key, required this.itemVal}) : super(key: key);
//
//   @override
//   State<Item> createState() => _ItemState();
// }
//
// class _ItemState extends State<Item> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.itemVal['Course'],
//                   style: Styles.priceTextStyle,
//                 ),
//                 Text(
//                   widget.itemVal['Lecturer'],
//                   style: Styles.cardTextStyle,
//                 ),
//                 Text(
//                   widget.itemVal['CreditUnit'],
//                   style: Styles.cardTextStyle,
//                 ),
//               ],
//             ),
//             InkWell(
//               onTap: () async {
//                 await FirebaseFirestore.instance
//                     .collection('ND1first')
//                     .doc(widget.itemVal.reference.id.toString())
//                     .delete();
//               },
//
//               //  },
//               child: const Icon(
//                 Icons.delete,
//                 color: Colors.red,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
