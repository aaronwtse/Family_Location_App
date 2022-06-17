//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:aaron_inspiring_quotes/stuff_to_be_imported/randomGenerators.dart';

class SignUpPage extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var usernameController =  TextEditingController();
  var cardHaving = TextEditingController();
  String locationController = "";
  String descriptionController = "";
  String profilePicController = "";

  //build sign up page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center (
        child: SingleChildScrollView (
          child: Column (
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text (
                    "Hello!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.asset(
                    'assets/guitar_pic.jpg'
                ),
                Container(
                  margin:
                  EdgeInsets.only(left: 35, right: 35, top: 16, bottom: 10),
                  child: TextField(
                    controller: emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  margin:
                  EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  margin:
                  EdgeInsets.only(left: 35, right: 35, top: 16, bottom: 10),
                  child: TextField(
                    controller: usernameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                      child: Text('Sign Up!'),
                      onPressed: () {
                        // get the email and password typed
                        print(emailController.text);
                        print(passwordController.text);
                        // deliver the materials to Google Firebase
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text, password: passwordController.text)
                            .then((authResult){
                          print("Successfully signed up UID! UID: " + authResult.user!.uid);

                          var userProfile =  {
                            'uid': authResult.user!.uid,
                            'email': emailController.text,
                            'password': passwordController.text,
                            'username': usernameController.text,
                            'location': randomUsername(),
                            'description': randomDescription(),
                            'profilePic': randomRepPic(),
                          };

                          FirebaseDatabase.instance.reference().child("users/" + authResult.user!.uid)
                              .set(userProfile)
                              .then((value) {
                            print("Successfully created a portfolio");
                          }).catchError((error) {
                            print("Failed to create a portfolio");
                          });

                          Navigator.pop(context);
                        }).catchError((error){
                          print("Failed to sign up!");
                          print(error.toString());
                        });
                      }
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}