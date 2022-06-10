import 'package:flutter/material.dart';

class ForgotPassWordPage extends StatelessWidget {
  const ForgotPassWordPage({Key? key}) : super(key: key);

//sets up screen to forgot password screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView (
          child: Column (
            children: <Widget> [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: const Text (
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                child: Image.asset(
                    'assets/buffalo_pic.jpg'
                ),
              ),
              Container(
                margin:
                const EdgeInsets.only(left: 35, right: 35, top: 16, bottom: 10),
                child: const TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Please input your username or email',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 20),
                width: 200,
                child: ElevatedButton(
                  child: Text('Reclaim account'),
                  onPressed: () {

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}