// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:junkyard/models/pin_pill_info.dart';
//
// class MapPinPillComponent extends StatefulWidget {
//   final double? pinPillPosition;
//
//   final DocumentSnapshot? pickupSnapshot;
//   String? awaiting;
//   State? state;
//
//   MapPinPillComponent({this.pinPillPosition, this.pickupSnapshot, this.awaiting, this.state});
//
//   @override
//   State<StatefulWidget> createState() => MapPinPillComponentState();
// }
//
// class MapPinPillComponentState extends State<MapPinPillComponent> {
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedPositioned(
//       top: widget.pinPillPosition,
//       right: 0,
//       left: 0,
//       duration: Duration(milliseconds: 200),
//       child: Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//             margin: EdgeInsets.all(20),
//             height: 70,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.all(Radius.circular(50)),
//                 boxShadow: <BoxShadow>[BoxShadow(blurRadius: 20, offset: Offset.zero, color: Colors.grey.withOpacity(0.5))]),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   width: 50,
//                   height: 50,
//                   margin: EdgeInsets.only(left: 10),
//                   child: ClipOval(child: Image.asset('assets/logos/usercurrentIcon.png', fit: BoxFit.cover)),
//                 ),
//                 Expanded(
//                   child: Container(
//                     margin: EdgeInsets.only(left: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         // Text("Request No: ${widget.pickupSnapshot!.get('requestNo')}", style: TextStyle(color: Colors.purple)),
//                         Center(
//                           child: TextButton(
//                             onPressed: () {
//                               FirebaseFirestore.instance
//                                   .collection("Pick Up")
//                                   .doc(widget.pickupSnapshot!.id)
//                                   .update({'confirmArrival': false}).then((value) {
//                                 setState(() {
//                                   widget.awaiting = "Awaiting arrival conformation";
//                                 });
//                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Confirmation Sent✔✔')));
//                                 // Navigator.pop(context);
//                               });
//                             },
//                             child: Text(
//                               "Send Arrival notice",
//                               style: TextStyle(fontSize: 16),
//                             ),
//                             style: TextButton.styleFrom(
//                               primary: Colors.purple,
//                             ),
//                           ),
//                         ),
//                         // Text('Latitude: ${widget.pickupSnapshot!.get('addressLatLng').latitude.toString()}',
//                         //     style: TextStyle(fontSize: 12, color: Colors.grey)),
//                         // Text('Longitude: ${widget.pickupSnapshot!.get('addressLatLng').longitude.toString()}',
//                         //     style: TextStyle(fontSize: 12, color: Colors.grey)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(15),
//                   child: Image.asset('assets/destination_map_marker.png', width: 50, height: 50),
//                 )
//               ],
//             )),
//       ),
//     );
//   }
// }
