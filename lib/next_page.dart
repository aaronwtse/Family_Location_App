import 'dart:async';
//import 'dart:html';

import 'package:aaron_inspiring_quotes/GPS_Stuff/get_location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MySecondPage extends StatefulWidget {
  const MySecondPage({Key? key}) : super(key: key);
  //final String title;

  @override
  _MySecondPageState createState() => _MySecondPageState ();
}

class _MySecondPageState extends State<MySecondPage> {
  final Completer<GoogleMapController> _mapController = Completer();
  late GoogleMapController mapController;
  final uid = FirebaseAuth.instance.currentUser!.uid.toString();
  final db = FirebaseDatabase.instance.reference();

  final LatLng _center = const LatLng(34.139729, -118.035347);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Friends Map'),
          backgroundColor: Colors.green[700],
        ),
        // body: GoogleMap(
        //   onMapCreated: _onMapCreated,
        //   initialCameraPosition: CameraPosition(
        //     target: _center,
        //     zoom: 11.0,
        //   ),
        // ),
        body: Stack(
          children: [
            StreamBuilder(stream: db.child("friends/"+uid)
                .orderByKey()
                .onValue,
              builder: (context,snapshot){
                final tilesList = <ListTile> [];
                if(snapshot.hasData) {
                  final cardsList = Map<String,dynamic>.from(
                      (snapshot.data! as Event).snapshot.value as Map);
                  cardsList.forEach((key, value) {
                    final nextCard = Map<String,dynamic>.from(value);
                    final orderTile = ListTile(
                      isThreeLine: true,
                      leading: const Icon(Icons.local_cafe),
                      title: Text(nextCard['name']
                      ),
                      subtitle: Text(
                          nextCard['latitude']  +" , "+ nextCard['longtitude']
                      ),
                    );
                    tilesList.add(orderTile);
                  });
                }
                return Column(
                  children: [
                    Flexible(
                        flex: 55,
                        child: StoreMap(
                            initialPosition: _center,
                            mapController: _mapController)
                    ),
                    Flexible(
                        flex: 45,
                        child: ListView(
                          children: tilesList,
                        )
                    ),

                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}


class StoreMap extends StatelessWidget {
  const StoreMap({
    Key? key,
    //required this.documents,
    required this.initialPosition,
    required this.mapController,
  }) : super(key: key);

  //final List<DocumentSnapshot> documents;
  final LatLng initialPosition;
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 12,
      ),
      // markers: documents
      //     .map((document) => Marker(
      //   markerId: MarkerId(document['placeId'] as String),
      //   icon: BitmapDescriptor.defaultMarkerWithHue(_pinkHue),
      //   position: LatLng(
      //     document['location'].latitude as double,
      //     document['location'].longitude as double,
      //   ),
      //   infoWindow: InfoWindow(
      //     title: document['name'] as String?,
      //     snippet: document['address'] as String?,
      //   ),
      // ))
      //     .toSet(),
      // onMapCreated: (mapController) {
      //   this.mapController.complete(mapController);
      // },
    );
  }
}
