// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
//
// class SearchProvider extends ChangeNotifier {
//   bool _isLoading = false;
//
//   bool get isLoading => _isLoading;
//
//   List<QueryDocumentSnapshot<Map<String, dynamic>>> _myList = [];
//   List<QueryDocumentSnapshot<Map<String, dynamic>>> get myList => _myList;
//
//   List<QueryDocumentSnapshot<Map<String, dynamic>>> _groupDisplay = [];
//   List<QueryDocumentSnapshot<Map<String, dynamic>>> get groupDisplay =>
//       _groupDisplay;
//
//   void searchNote(String query) {
//     if (query.isEmpty) {
//       _groupDisplay = _myList;
//       notifyListeners();
//     } else {
//       _groupDisplay = _myList
//           .where((item) => item[0]['name']
//               .toString()
//               .toLowerCase()
//               .contains(query.toString().toLowerCase()))
//           .toList();
//       notifyListeners();
//     }
//   }
//
//   void fetchData() async {
//     _groupDisplay = [];
//
//     _isLoading = true;
//     notifyListeners();
//
//     final snap = await FirebaseFirestore.instance.collection('Islamiya').get();
//     print(snap.docs[0]['name']);
//
//     final snap2 = snap.docs
//         .where((element) =>
//             element["uid"] == FirebaseAuth.instance.currentUser?.uid)
//         .toList();
//     print('snap88 ${snap2.length}');
//     print('snap ${snap.docs.length}');
//     print('snap ${snap2[0]['name']}');
//     _myList = snap2;
//     _groupDisplay.addAll(_myList);
//
//     _isLoading = false;
//     notifyListeners();
//   }
// }
