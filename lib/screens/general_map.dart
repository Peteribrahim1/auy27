import 'dart:async';
import 'package:auy27/screens/save_current_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:location/location.dart';

class GeneralMap extends StatefulWidget {
  const GeneralMap({super.key});

  @override
  State<GeneralMap> createState() => _GeneralMapState();
}

class _GeneralMapState extends State<GeneralMap> {
  // zoom = 14.5;
  Set<Marker> mark = {};
  List<QueryDocumentSnapshot<Map<String, dynamic>>> myList = [];

  Map<MarkerId, Marker> markers = {};
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(10.274604715, 11.1225046625);
  static const LatLng _pApplePark = LatLng(10.3063, 11.1426);
  LatLng? _currentP = null;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    print("current loc $_currentP");
    getLocationUpdates();

    setState(() {});
  }

  Future<void> getCurrentLocation() async {
    Position? position = await Geolocator.getLastKnownPosition();
    print('my new position is ${position!.latitude}');
    _currentP = LatLng(position.latitude, position.longitude);
    setState(() {});
    fetchData();
  }

  void fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final snap =
        await FirebaseFirestore.instance.collection('General Map').get();
    myList = snap.docs;
    for (int i = 0; i < myList.length; i++) {
      mark.addLabelMarker(
        LabelMarker(
          label: myList[i]['name'],
          markerId: MarkerId("_destinationLocation$i"),
          position: LatLng(myList[i]['latitude'], myList[i]['longitude']),
          infoWindow: InfoWindow(
            title: myList[i]['address'],
            snippet: '${myList[i]['phone']}',
          ),
        ),
      );
      setState(() {});
    }

    //  ${myList[i]['lga']}\n${myList[i]['phone']}}

    mark.addLabelMarker(
      LabelMarker(
        onTap: () async {
          await showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) => SaveCurrentDialog(
                    latitude: _currentP!.latitude,
                    longitude: _currentP!.longitude,
                  ));

          fetchData();

          setState(() {});
        },
        label: "current",
        markerId: MarkerId("_currentLocation"),
        position: LatLng(_currentP!.latitude, _currentP!.longitude),
        backgroundColor: Colors.green,
      ),
    );
    setState(() {});

    //  print('marker ID
    Marker currentMarker = Marker(
      onTap: () async {
        await showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) => SaveCurrentDialog(
                  latitude: _currentP!.latitude,
                  longitude: _currentP!.longitude,
                ));

        fetchData();

        setState(() {});
      },
      markerId: MarkerId("_currentLocation"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: LatLng(_currentP!.latitude, _currentP!.longitude),
    );
    markers[currentMarker.markerId] = currentMarker;
    setState(() {
      _isLoading = false;
    });
  }

  bool _isLoading = false;

  addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'General Map',
      //     style: Styles.appBarTextStyle,
      //   ),
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   backgroundColor: const Color.fromRGBO(47, 79, 79, 1),
      // ),
      body: _currentP == null
          ? const Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              zoomControlsEnabled: true,
              tiltGesturesEnabled: false,
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: _currentP!,
                zoom: 14.5,
              ),
              onCameraMove: (CameraPosition cameraPosition) {
                CameraUpdate.newCameraPosition(CameraPosition(
                    zoom: cameraPosition.zoom, target: _pGooglePlex));
                print('lets check camera position');
                //  zoom = cameraPosition.zoom;
                setState(() {});
                print(cameraPosition.zoom);
              },
              onCameraMoveStarted: () {
                CameraUpdate.newCameraPosition(
                    CameraPosition(zoom: 50, target: _pGooglePlex));
                print('lets check camera position');

                setState(() {});
              },
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

          print("my current location is $_currentP");
        });
      }
    });
    print("your current location is $_currentP");
  }
}
