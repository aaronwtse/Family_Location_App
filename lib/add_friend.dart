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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
            controller: nameController,
            obscureText: false,
            decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText:'Name',
            )
            ),
            TextField(
                controller: emailController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:'Email',
                )
            ),
            ElevatedButton(
              child: Text("Add Friend"),
              onPressed: () {
                print(nameController.text);
                print(emailController.text);

                var timestamp = new DateTime.now().millisecondsSinceEpoch;
                FirebaseDatabase.instance.reference().child("friends/person" + timestamp.toString()).set(
                  {
                    "name" : nameController.text,
                    "email" : emailController.text,
                  }
                ).then((value) {
                  print("Sucessfully added friend. ");
                }).catchError((error) {
                  print("Failed to add. " + error.toString());
                });
              },
            )

          ],
        ),
      ),
    );
  }
}
