// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../screens/academia/academia_details.dart';
//
// class AkkoReport extends StatefulWidget {
//   const AkkoReport({super.key});
//
//   @override
//   State<AkkoReport> createState() => _AkkoReportState();
// }
//
// class _AkkoReportState extends State<AkkoReport> {
//   List<QueryDocumentSnapshot<Map<String, dynamic>>> _myList = [];
//   List<QueryDocumentSnapshot<Map<String, dynamic>>> _groupDisplay = [];
//
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _fetchData();
//   }
//
//   void _fetchData() async {
//     setState(() {
//       _isLoading = true;
//     });
//     final snap = await FirebaseFirestore.instance.collection('Academia').get();
//
//     final snap2 = snap.docs.toList();
//     // .where((element) =>
//     //     element["uid"] == FirebaseAuth.instance.currentUser?.uid)
//     // .toList();
//     _myList = snap2.reversed.toList();
//     _groupDisplay.addAll(_myList);
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: ListView.builder(
//           shrinkWrap: true,
//           itemCount: _groupDisplay.length,
//           itemBuilder: (context, index) {
//             final data = _groupDisplay[index];
//             print(data.reference.id.toString());
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => AcademiaDetails(
//                               ref: data.reference.id,
//                               receive: data,
//                               id: data['id'],
//                               category: widget.category,
//                             )),
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: const Color.fromRGBO(249, 249, 249, 1),
//                   ),
//                   child: Column(
//                     children: [
//                       ListTile(
//                         title: Text(
//                           data['name'],
//                         ),
//                         // subtitle: Text(
//                         //   data['qualification'],
//                         // ),
//                         // trailing: Text(
//                         //   'Rank: ${data['rank']}',
//                         // ),
//                       ),
//                       const Divider(color: Colors.grey),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
