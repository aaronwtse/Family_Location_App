//importing other programs to be used.
import 'package:aaron_inspiring_quotes/profile_page.dart';
import 'package:aaron_inspiring_quotes/stuff_to_be_imported//homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'forgotPassword.dart';
import 'signUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //crafting login page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView (
            child: Column(
              children: <Widget> [
                Container(
                    child: Image.asset('assets/inspiring_pic_1.jpg',scale: 2)
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin:
                  EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
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
                  margin: EdgeInsets.only(top: 5),
                  child: new GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassWordPage()),
                      );
                    },
                    child: new Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  width: 200,
                  child: ElevatedButton(
                      child: Text('Log In'),
                      onPressed: () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                            .then((value) {
                          print("Successfully Logged in!");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()),
                          );
                        }).catchError((error) {
                          print("Failed to log in!");
                          print(error.toString());
                        });
                      }
                  ),
                ),
                Container(
                  child: new GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: new Text(
                      "Create new Account",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}




