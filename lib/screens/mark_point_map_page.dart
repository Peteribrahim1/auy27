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

class MarkPointMapPage extends StatefulWidget {
  const MarkPointMapPage(
      {super.key,
      required this.ref,
      required this.category,
      this.name,
      this.phone});
  final String ref;
  final String category;
  final String? name;
  final String? phone;

  @override
  State<MarkPointMapPage> createState() => _MarkPointMapPageState();
}

class _MarkPointMapPageState extends State<MarkPointMapPage> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> myList = [];
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  String? getName;
  String? getPhone;
  String? getCat;

  // static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  // static const LatLng _pApplePark = LatLng(37.3346, -122.0090);

  static const LatLng _pGooglePlex = LatLng(10.274604715, 11.1225046625);
  static const LatLng _pApplePark = LatLng(10.299350, 11.174090);
  LatLng? _currentP = null;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    //print("current loc $_currentP");
    getLocationUpdates();
    _fetchData();
    //     .then(
    //   (_) => {
    //     getPolylinePoints().then((coordinates) => {
    //           generatePolyLineFromPoints(coordinates),
    //         }),
    //   },
    // );
    // _pApplePark = LatLng(latitude, longitude);
    setState(() {});
  }

  // 10.2930017
  bool _isLoading = false;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final snap =
        await FirebaseFirestore.instance.collection(widget.category).get();
    print(snap.docs[0]['name']);

    final snap2 = snap.docs
        .where((element) =>
            element["uid"] == FirebaseAuth.instance.currentUser?.uid)
        .toList();
    print('snap2 ${snap2.length}');
    print('snap ${snap.docs.length}');
    print('snap ${snap2[0]['name']}');
    myList = snap2;
    print('my rapid ${myList[0]['name']}');
    getName = myList[0]['name'];
    getPhone = myList[0]['phone'];
    getCat = myList[0]['denomination'];
    print('get name $getName');
    setState(() {
      _isLoading = false;
    });
  }

  //save location
  void _saveLocation(
    double latitude,
    double longitude,
  ) async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().saveCoordinatesPolitical(
      latitude: latitude,
      longitude: longitude,
      reference: widget.ref,
      category: widget.category,
    );
    print('save to general');
/////
    await AuthMethods().saveGeneralCoordinates(
      name: widget.name ?? 'name',
      phone: widget.phone ?? '6566',
      category: 'name',
      latitude: _currentP!.latitude,
      longitude: _currentP!.latitude,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Current Location saved!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Save Current Location',
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
              tiltGesturesEnabled: false,
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: _currentP!,
                zoom: 13,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                  position: _currentP!,
                  infoWindow: InfoWindow(
                    title: "Current",
                    snippet: "location",
                  ),
                ),

                // const Marker(
                //     markerId: MarkerId("_sourceLocation"),
                //     icon: BitmapDescriptor.defaultMarker,
                //     position: _pGooglePlex),
                // const Marker(
                //     markerId: MarkerId("_destionationLocation"),
                //     icon: BitmapDescriptor.defaultMarker,
                //     position: _pApplePark)
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
      floatingActionButton: SizedBox(
        width: 100,
        child: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(47, 79, 79, 1),
          child: const Text(
            'Save Location',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            _saveLocation(_currentP!.latitude, _currentP!.longitude);
            print(_currentP?.longitude);
          },
        ),
      ),
    );
  }

  // Future<void> _cameraToPosition(LatLng pos) async {
  //   final GoogleMapController controller = await _mapController.future;
  //   CameraPosition _newCameraPosition = CameraPosition(
  //     target: pos,
  //     zoom: 13,
  //   );
  //   await controller.animateCamera(
  //     CameraUpdate.newCameraPosition(_newCameraPosition),
  //   );
  // }

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
          // _cameraToPosition(_currentP!);
          print("my current location is $_currentP");
          print(_currentP?.latitude);
        });
      }
    });
    //  print("your current location is $_currentP");
  }
}
