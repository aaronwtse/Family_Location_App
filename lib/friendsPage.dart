import 'package:aaron_inspiring_quotes/add_friend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  var userProfile;
  final db = FirebaseDatabase.instance.reference();
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    print(uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Map and Friends"),
        backgroundColor: const Color.fromRGBO(33, 97, 170, 1.0),
      ),
      body: Stack(
        children: [
          StreamBuilder(stream: db.child("friends/" + uid)
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
                    leading: const Icon(Icons.local_cafe),
                    title: Text(nextCard['name']
                    ),
                    subtitle: Text(
                        nextCard['latitude'] +' , '+ nextCard['longtitude']),
                  );
                  tilesList.add(orderTile);
                });
              }
              return ListView(
                children: tilesList,
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddFriendPage()),
            );
          }
      ),
    );
  }
}







