// import 'dart:convert';
// import 'package:flutter/material.dart';
//
// import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;
//
// import '../utillities/secret.dart';
// import '../utillities/tools.dart';
//
// class SearchMap extends StatefulWidget {
//   final List<dynamic>? searchValue;
//   final String? searchCoordinate;
//
//   SearchMap({Key? key, this.searchValue, this.searchCoordinate})
//       : super(key: key);
//
//   @override
//   _SearchMapState createState() => _SearchMapState();
// }
//
// class _SearchMapState extends State<SearchMap> {
//   String? searchValue;
//
//   var _controller = TextEditingController();
//   var uuid = new Uuid();
//
//   // String? _sessionToken;
//   List<dynamic>? _placeList = [];
//   String? placeId;
//   Secret _secret = Secret();
//   bool _progressController = true;
//   List<dynamic> locationDetails = [];
//
//   // List<PlacePredictions> placePredictionList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       getSuggestion(_controller.text);
//     });
//   }
//
//   void getSuggestion(String input) async {
//     try {
//       String baseURL =
//           'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//       String request = '$baseURL?input=$input&key=${_secret.googleMapsAPIKey}';
//       var response = await http.get(Uri.parse(request));
//       if (response.statusCode == 200) {
//         setState(() {
//           _placeList = json.decode(response.body)['predictions'];
//           _progressController = false;
//         });
//
//         print("PlaceList:  $_placeList");
//       } else {
//         _progressController = false;
//         throw Exception('Failed to load predictions');
//       }
//     } catch (e) {
//       print("New Errorssss: ${e.toString()}");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       color: Colors.white,
//       child: Stack(
//         children: <Widget>[
//           Scaffold(
//             backgroundColor: Colors.transparent,
//             appBar: AppBar(
//               iconTheme: const IconThemeData(
//                 color: Colors.black,
//               ),
//               title: const Text(
//                 "Search Location",
//                 style: TextStyle(
//                     color: Color.fromRGBO(47, 79, 79, 1),
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold),
//               ),
//               centerTitle: true,
//               backgroundColor: Colors.transparent,
//               elevation: 0.0,
//             ),
//             body: SingleChildScrollView(
//               child: Container(
//                 child: Column(
//                   children: [
//                     Container(
//                       color: Colors.white,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             InkWell(
//                               onTap: () {
//                                 Navigator.pop(context, locationDetails);
//                                 //Navigator.of(context).push(MaterialPageRoute(
//                                 //    builder: (context) => Earnings()));
//                               },
//                               child: Container(
//                                 margin: const EdgeInsets.all(10),
//                                 alignment: Alignment.centerLeft,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFF5F5F5),
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 height: 50.0,
//                                 child: TextFormField(
//                                   //initialValue: ' ${widget.searchValue}',
//                                   controller: _controller,
//                                   validator: (value) => value!.isEmpty
//                                       ? "Fill out the origin address"
//                                       : null,
//                                   keyboardType: TextInputType.streetAddress,
//                                   onChanged: (value) {
//                                     // setState(() {
//                                     //   findDestinationPlace(value);
//                                     // });
//                                     setState(() => searchValue = value);
//                                   },
//                                   style: const TextStyle(
//                                     color: Colors.black,
//                                   ),
//                                   decoration: const InputDecoration(
//                                     border: InputBorder.none,
//                                     contentPadding: EdgeInsets.all(14.0),
//                                     hintText: 'Fill out the origin address',
//                                     hintStyle: TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     _progressController && _controller.text.isNotEmpty
//                         ? const Padding(
//                             padding: EdgeInsets.only(top: 28.0),
//                             child: CircularProgressIndicator(),
//                           )
//                         : ListView.builder(
//                             physics: const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: _placeList!.length,
//                             itemBuilder: (context, index) {
//                               return ListTile(
//                                 // contentPadding: EdgeInsets.symmetric(
//                                 //     horizontal: 15, vertical: 5),
//                                 leading: CircleAvatar(
//                                   backgroundColor: Tools.hexToColor('#f5f5f5'),
//                                   child: Icon(
//                                     Icons.location_on,
//                                     color: Tools.hexToColor('#1F9C00'),
//                                   ),
//                                 ),
//                                 title: SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   physics: const ScrollPhysics(),
//                                   child: Text(
//                                     _placeList![index]["description"],
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                                 subtitle: Text(
//                                   _placeList![index]["structured_formatting"]
//                                       ['main_text'],
//                                   maxLines: 2,
//                                   softWrap: true,
//                                 ),
//                                 onTap: () async {
//                                   String request =
//                                       'https://maps.googleapis.com/maps/api/place/details/json?place_id=${_placeList![index]["place_id"]}&key=${Secret().googleMapsAPIKey}';
//                                   var response =
//                                       await http.get(Uri.parse(request));
//
//                                   Map<String, dynamic> map =
//                                       json.decode(response.body);
//                                   //print(map['result']['geometry']['location']);
//
//                                   print(map['result']['geometry']['location']
//                                       ['lat']);
//                                   print(map['result']['geometry']['location']
//                                       ['lng']);
//                                   double? latitude = map['result']['geometry']
//                                       ['location']['lat'];
//                                   double? longitude = map['result']['geometry']
//                                       ['location']['lng'];
//                                   print('$latitude $longitude');
//                                   locationDetails = [
//                                     _placeList![index]["description"],
//                                     map['result']['geometry']['location']
//                                         ['lat'],
//                                     map['result']['geometry']['location']['lng']
//                                   ];
//
//                                   Navigator.pop(context, locationDetails
//                                       //_placeList[index]["description"],
//                                       );
//                                   print('coordinates are $locationDetails');
//                                 },
//                               );
//                             },
//                           )
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     ));
//   }
// }
import 'package:auy27/screens/live_chat.dart';
import 'package:flutter/material.dart';

import '../resources/styles.dart';

class SearchMap extends StatelessWidget {
  const SearchMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 52,
                width: 280,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LiveChat(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(47, 79, 79, 1),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Proceed to support',
                    style: Styles.buttonTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
