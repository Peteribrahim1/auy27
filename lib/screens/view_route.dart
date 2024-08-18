import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:label_marker/label_marker.dart';
import 'package:location/location.dart';

import '../resources/styles.dart';
import '../utillities/consts.dart';

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

  LatLng _pApplePark = LatLng(10.3063, 11.1426);
  LatLng? _currentP = null;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
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
              polylines: Set<Polyline>.of(polylines.values),
            ),
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
          // _cameraToPosition(_currentP!);
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
