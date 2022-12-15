import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Example extends StatefulWidget {
  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  Completer<GoogleMapController> _controller = Completer();
  Location location = new Location();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    setState(() {
      
    });
    print(_locationData);
  }
  
  final Set<Marker> markers = {};
  addMarkers(){
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId('current-location'),
          position: LatLng(_locationData!.latitude!.toDouble(), _locationData!.longitude!.toDouble()),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: 'learning-approach'
          )
        )
      );
    });
  }


  @override
  void initState() {
    getLocation();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('learning-approach'),
        automaticallyImplyLeading: false,
      ),
      body: _locationData != null ? GoogleMap(
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(_locationData!.latitude!.toDouble(), _locationData!.longitude!.toDouble()),
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          addMarkers();
        },
        markers: markers,
      ): Center(
        child: CircularProgressIndicator(),
      )
    
    );
  }
}
