// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:tracker/core/services/locationService.dart';
import 'package:tracker/screens/received.dart';
import 'package:tracker/screens/share_location.dart';
import 'package:tracker/shared/optimalText.dart';

import '../utils/router.dart';

class MapScreen extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  LocationService _locationService = LocationService();
  final Completer<GoogleMapController> _controller = Completer();
  double lat = 0.0;
  double long = 0.0;
  @override
  void initState() {
    super.initState();
    getLocation();
    _locationService.getLocationStream();
  }

  void getLocation() async {
    Position location = await _locationService.getLocation();
    setState(() {
      lat = location.latitude;
      long = location.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.chat_bubble_outline,
              color: Colors.black,
            ),
            onPressed: () {
              RouteController().push(context, Received());
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.share_location,
                color: Colors.black,
              ),
              onPressed: () {
                RouteController().push(context, ShareScreen());
              },
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "My location",
            style: TextStyle(
                fontSize: OptimalText().optimizeText(18, context),
                color: Colors.blue),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(color: Colors.black),
        ));
  }
}
