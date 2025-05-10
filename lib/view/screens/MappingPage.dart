import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MappingPage extends StatefulWidget {
  @override
  _MappingPageState createState() => _MappingPageState();
}

class _MappingPageState extends State<MappingPage> {
  GoogleMapController? _mapController;
  Marker? _currentLocationMarker;

  final Set<Marker> _markers = {};
  LatLng? _currentLatLng;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    _currentLatLng = LatLng(position.latitude, position.longitude);

    // Add initial marker
    _updateMarker(_currentLatLng!);

    // Move camera once map is ready
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(_currentLatLng!),
      );
    }

    // Listen to location updates
    Geolocator.getPositionStream().listen((Position newPosition) {
      _currentLatLng = LatLng(newPosition.latitude, newPosition.longitude);
      _updateMarker(_currentLatLng!);
      _mapController?.animateCamera(CameraUpdate.newLatLng(_currentLatLng!));
    });
  }

  void _updateMarker(LatLng position) {
    final marker = Marker(
      markerId: MarkerId('current_location'),
      position: position,
      infoWindow: InfoWindow(title: 'You are here'),
    );

    setState(() {
      _markers.clear();
      _markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentLatLng ?? LatLng(0, 0),
          zoom: 15,
        ),
        markers: _markers,
        onMapCreated: (controller) {
          _mapController = controller;

          // Move camera to current location once it's loaded
          if (_currentLatLng != null) {
            _mapController!.animateCamera(
              CameraUpdate.newLatLng(_currentLatLng!),
            );
          }
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
