import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:learning_approach/place.dart';
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
    setState(() {});
    print(_locationData);
  }

  // final Set<Marker> markers = {};
  
  // addMarkers() {
  //   setState(() {
  //     markers.add(Marker(
  //         markerId: MarkerId('current-location'),
  //         position: LatLng(_locationData!.latitude!.toDouble(),
  //             _locationData!.longitude!.toDouble()),
  //         icon: BitmapDescriptor.defaultMarker,
  //         infoWindow: InfoWindow(title: 'learning-approach')));
  //   });
  // }

  // map clustering

  late ClusterManager _manager;
  Set<Marker> markers = Set();

  List<Place> items = [
    Place(
      name: '00',
      latLng: LatLng(23.9978, 90.4202),
    ),
    Place(
      name: '01',
      latLng: LatLng(23.9504, 90.3799),
    ),
    Place(
      name: '02',
      latLng: LatLng(23.9910, 90.3908),
    ),
    Place(
      name: '03',
      latLng: LatLng(23.9884, 90.3876),
    ),
    Place(
      name: '04',
      latLng: LatLng(23.9925, 90.3819),
    ),
    Place(
      name: '05',
      latLng: LatLng(23.7455, 90.3776),
    ),
    Place(
      name: '06',
      latLng: LatLng(23.7453, 90.3772),
    ),
    Place(
      name: '07',
      latLng: LatLng(23.7467, 90.3767),
    ),
    Place(
      name: '08',
      latLng: LatLng(23.7478, 90.3776),
    ),
    Place(
      name: '09',
      latLng: LatLng(23.7458, 90.3763),
    ),
  ];

  ClusterManager _initClusterManager() {
    return ClusterManager(
      items,
      _updateMarkers,
      markerBuilder: _markerBuilder,
    );
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
  }

  Future<Marker> Function(Cluster<ClusterItem>) get _markerBuilder =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            print('---- $cluster');
            cluster.items.forEach((p) => print(p));
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.orange;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  @override
  void initState() {
    getLocation();
    _manager = _initClusterManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('learning-approach'),
          automaticallyImplyLeading: false,
        ),
        body: _locationData != null
            ? GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                compassEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(_locationData!.latitude!.toDouble(),
                      _locationData!.longitude!.toDouble()),
                  zoom: 14,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  _manager.setMapId(controller.mapId);
                },
                onCameraMove: _manager.onCameraMove,
                onCameraIdle: _manager.updateMap,
                markers: markers,
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
