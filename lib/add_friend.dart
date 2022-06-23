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
            //left of video 25 @ 8:20
          ],
        ),
      ),
    );
  }
}
