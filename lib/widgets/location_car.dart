import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationCar extends StatefulWidget {
  final String address;

  const LocationCar({Key? key, required this.address}) : super(key: key);

  @override
  _LocationCarState createState() => _LocationCarState();
}

class _LocationCarState extends State<LocationCar> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCoordinatesFromAddress();
  }

  Future<void> _getCoordinatesFromAddress() async {
    try {
      List<Location> locations = await locationFromAddress(widget.address);
      if (locations.isNotEmpty) {
        final location = locations.first;
        setState(() {
          _currentPosition = CameraPosition(
            target: LatLng(location.latitude, location.longitude),
            zoom: 14.4746,
          );
        });
        if (_controller.isCompleted) {
          final GoogleMapController controller = await _controller.future;
          controller
              .animateCamera(CameraUpdate.newCameraPosition(_currentPosition!));
        }
      }
    } catch (e) {
      print("Error fetching coordinates: $e");
      // Handle different error cases
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to fetch location coordinates: $e'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _currentPosition ??
                CameraPosition(
                    target: LatLng(10.8020, 106.6759), zoom: 14.4746),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              if (_currentPosition != null) {
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(_currentPosition!));
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton.extended(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              if (_currentPosition != null) {
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(_currentPosition!));
              }
            },
            label: const Text('Go to Location'),
            icon: const Icon(Icons.location_on),
          ),
        ),
      ],
    );
  }
}
