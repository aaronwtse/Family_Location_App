import 'package:aaron_inspiring_quotes/friendsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class AddFriendPage extends StatefulWidget {
  const AddFriendPage({Key? key}) : super(key: key);

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var latController = TextEditingController();
  var longController = TextEditingController();
  final ref1 = FirebaseDatabase.instance.reference().child("users/");
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    var friendsUID1;
    var friendsProfile;
    var name1;
    var email1;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
            controller: nameController,
            obscureText: false,
            decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText:'Name',
            )
            ),
            TextField(
                controller: emailController,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:'Email',
                )
            ),
            ElevatedButton(
              child: Text("Add Friend"),
              onPressed: () {
                print(nameController.text);
                print(emailController.text);



                var timestamp = DateTime.now().millisecondsSinceEpoch;
                ref1.orderByChild("email").equalTo(emailController.text).onValue.listen((event) {
                  print(event.snapshot.value);
                  friendsProfile = event.snapshot.value;
                  final cardList = Map<String,dynamic>.from(friendsProfile);
                  cardList.forEach((key, value) {
                    final nextCard = Map<String,dynamic>.from(value);
                    var friendsUID = nextCard['uid'];
                    var username = nextCard['username'];
                    var email = nextCard['email'];
                    friendsUID1 = friendsUID ;
                    name1 = username;
                    email1 = email;
                  }
                  );
                  print(friendsUID1);
                  DatabaseReference ListPush= FirebaseDatabase.instance.reference().child("friends/" + uid+"/" +friendsUID1);
                  ListPush.set({
                    "email": email1,
                    "latitude": "77.0047",
                    "longtitude": "38.8887",
                    "name": name1,
                    "time": "1656908949094"
                  });

                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              }),
          ],
        ),
      ),
    );
  }
}


