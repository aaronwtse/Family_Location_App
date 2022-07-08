import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GetLocationWidget extends StatefulWidget {
  const GetLocationWidget({super.key});

  @override
  State<GetLocationWidget> createState() => _GetLocationWidgetState();
}

class _GetLocationWidgetState extends State<GetLocationWidget> {
  bool _loading = false;

  LocationData? _location;
  String? _error;

  Future<void> _getLocation() async {
    setState(() {
      _error = null;
      _loading = true;
    });
    try {
      final _locationResult = await getLocation(
        settings: LocationSettings(ignoreLastKnownPosition: true),
      );

      setState(() {
        _location = _locationResult;
        _loading = false;
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
        _loading = false;
      });
    }
  }


  void pushToFirebaseLA() {
    FirebaseDatabase.instance.reference().child("users/" + FirebaseAuth.instance.currentUser!.uid + "/latitude")
        .set('${_location?.latitude}'.toString())
        .then((value) {
      print("Successfully created a portfolio");
    }).catchError((error) {
      print("Failed to create a portfolio");
    });
  }

  void pushToFirebaseLO() {
    FirebaseDatabase.instance.reference().child("users/" + FirebaseAuth.instance.currentUser!.uid + "/longitude")
        .set('${_location?.longitude}'.toString())
        .then((value) {
      print("Successfully created a portfolio");
    }).catchError((error) {
      print("Failed to create a portfolio");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _error ??
                'Location: ${_location?.latitude}, ${_location?.longitude}',
            style: Theme.of(context).textTheme.bodyText1,
          ),

          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed:()=>[_getLocation(), pushToFirebaseLO(), pushToFirebaseLA()],
                child: _loading
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : const Text('Get'),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class StoreMap extends StatelessWidget {
  const StoreMap({
    required Key key,
    required this.documents,
    required this.initialPosition,
    required this.mapController,
  }) : super(key: key);

  final List<DocumentSnapshot> documents;
  final LatLng initialPosition;
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 12,
      ),
      markers: documents
          .map((document) => Marker(
        markerId: MarkerId(document['placeId']),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(
          document['location'].latitude,
          // document{_location?.latitude},
          // document{_location?.longitude},
          document['location'].longitude,
        ),
        infoWindow: InfoWindow(
          title: document['name'],
          snippet: document['address'],
        ),
      ))
          .toSet(),
      onMapCreated: (mapController) {
        this.mapController.complete(mapController);
      },
    );
  }
}



