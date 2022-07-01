import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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


  // final FirebaseAuth auth = FirebaseAuth.instance;
  //
  // void inputData() {
  //   final User? user = auth.currentUser;
  //   final uid = user?.uid;
  //   // here you write the codes to input the data into firestore
  //   //var uid = user?.uid;
  //   FirebaseDatabase.instance.reference().child("users/" + FirebaseAuth.uid = user?.uid.user).set(
  //       {
  //         "latitude" : _location?.latitude,
  //         "longitude" : _location?.longitude,
  //
  //       }
  //   );
  // }


  void pushToFirebase() {
    // FirebaseDatabase.instance.reference().child("users/person" + timestamp.toString()).set(
    FirebaseDatabase.instance.reference().child("users/" + FirebaseAuth._firebaseauth.currentUser.toString()).set(
        {
          "latitude" : _location?.latitude,
          "longitude" : _location?.longitude,

        }
    );
  }

  // void pushToFirebase() {
  //   // FirebaseDatabase.instance.reference().child("users/person" + timestamp.toString()).set(
  //   FirebaseDatabase.instance.reference().child("users/" + FirebaseAuth._firebaseauth.currentUser.toString()).set(
  //       {
  //         "latitude" : _location?.latitude,
  //         "longitude" : _location?.longitude,
  //
  //       }
  //   );
  // }

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
                onPressed:()=>[_getLocation(), pushToFirebase()],
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


