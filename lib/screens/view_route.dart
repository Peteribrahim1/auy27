import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:label_marker/label_marker.dart';

import 'package:location/location.dart';

import '../resources/auth_methods.dart';
import '../resources/styles.dart';
import '../utillities/consts.dart';
import '../utils/utils.dart';

class ViewRoute extends StatefulWidget {
  const ViewRoute({super.key, required this.category, required this.id});
  final String id;
  final String category;

  @override
  State<ViewRoute> createState() => _ViewRouteState();
}

class _ViewRouteState extends State<ViewRoute> {
  Set<Marker> mark = {};
  double? latitude;
  double? longitude;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> myList = [];
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  // static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  // static const LatLng _pApplePark = LatLng(37.3346, -122.0090);

  // static const LatLng _pGooglePlex = LatLng(10.274604715, 11.1225046625);
  LatLng _pApplePark = LatLng(10.3063, 11.1426);
  LatLng? _currentP = null;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    // fetchLatLong();
    // print("current loc $_currentP");
  }

  Future<void> getCurrentLocation() async {
    print('let us start some work');
    Position? position = await Geolocator.getLastKnownPosition();
    print('my new position is ${position!.latitude}');
    _currentP = LatLng(position.latitude, position.longitude);

    setState(() {});
    fetchLatLong();
  }

  bool _isLoading = false;

  void fetchLatLong() async {
    mark.addLabelMarker(
      LabelMarker(
          label: 'current',
          markerId: MarkerId("_current"),
          position: LatLng(_currentP!.latitude, _currentP!.longitude!),
          backgroundColor: Colors.lightGreen),
    );
    setState(() {});
    setState(() {
      _isLoading = true;
    });
    final snap = await FirebaseFirestore.instance
        .collection(widget.category)
        .where("id", isEqualTo: widget.id)
        .get();
    print('print snap ${snap.docs.length}');
    if (snap.docs.isNotEmpty) {
      latitude = snap.docs[0]['latitude'];
      longitude = snap.docs[0]['longitude'];
      print('my assigned latitude is $latitude');
      _pApplePark = LatLng(latitude!, longitude!);

      mark.addLabelMarker(
        LabelMarker(
          label: snap.docs[0]['name'],
          markerId: MarkerId("_destination"),
          position: LatLng(latitude!, longitude!),
        ),
      );
      setState(() {});
    }
    // print(snap.docs[0]['name']);;
    //
    // final snap2 = snap.docs
    //     .where((element) =>
    //         element["uid"] == FirebaseAuth.instance.currentUser?.uid)
    //     .toList();
    // // print('snap2 ${snap2.length}');
    // myList = snap2;
    // // final item = myList.firstWhere((location) => location['address'] == "dfbh");
    // // debugPrint("The latitude is: ${item['latitude']}");
    // final data = myList[1];
    // latitude = data['latitude'];
    // longitude = data['longitude'];
    // print('my assigned latitude is $latitude');
    // _pApplePark = LatLng(latitude!, longitude!);
    // print('yyyyyyy${_pApplePark.latitude}');
    setState(() {
      _isLoading = false;
    });

    getLocationUpdates().then(
      (_) => {
        getPolylinePoints().then((coordinates) => {
              generatePolyLineFromPoints(coordinates),
            }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Route',
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(47, 79, 79, 1),
      ),
      body: _currentP == null
          ? const Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: _currentP!,
                zoom: 14.5,
              ),
              markers: mark,
              // markers: {
              //   Marker(
              //     markerId: const MarkerId("_currentLocation"),
              //     icon: BitmapDescriptor.defaultMarkerWithHue(
              //         BitmapDescriptor.hueGreen),
              //     position: _currentP!,
              //   ),
              //   // Marker(
              //   //     markerId: MarkerId("_sourceLocation"),
              //   //     icon: BitmapDescriptor.defaultMarker,
              //   //     position: _pGooglePlex),
              //   Marker(
              //       markerId: MarkerId("_destionationLocation"),
              //       icon: BitmapDescriptor.defaultMarkerWithHue(
              //           BitmapDescriptor.hueBlue),
              //       position: _pApplePark)
              // },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
          print("my current location is $_currentP");
          print(_currentP?.longitude);
        });
      }
    });
    print("your current location is $_currentP");
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(_currentP!.latitude, _currentP!.longitude),
      PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }
}

// Future<List<LatLng>> getPolylinePoints() async {
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//     GOOGLE_MAPS_API_KEY,
//     PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
//     PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
//     travelMode: TravelMode.driving,
//   );
//   if (result.points.isNotEmpty) {
//     result.points.forEach((PointLatLng point) {
//       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//     });
//   } else {
//     print(result.errorMessage);
//   }
//   return polylineCoordinates;
// }
