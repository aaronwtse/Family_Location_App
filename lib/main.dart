import 'dart:io'; //imports dart library

import 'package:aaron_inspiring_quotes/stuff_to_be_imported/login_page.dart';
import 'package:flutter/material.dart'; //importing flutter widgets using material design
import 'package:firebase_core/firebase_core.dart'; //enables connecting to multiple firebase apps


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //flutter needs to call native code before calling runApp, makes sure you have an instance of WidgetsBinding
  await Firebase.initializeApp(); //initialize firebase
  runApp(const MyApp()); //return widget that would be attached to the screen as a root of the widget Tree that will be rendered
  HttpOverrides.global = MyHttpOverrides(); //overriding HTTP client (client communicates with HTTP server)
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) { //description of widget position in the widget tree
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, //turns on a debug banner in debug mode to show app is in debug mode
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, //color of the material widget that underlies entire scaffold
        appBarTheme: const AppBarTheme( //sets settings for top bit
          backgroundColor: Colors.white, //sets color to white
          elevation: 0, //default elevation
        ),
        primarySwatch: Colors.blue, //primaryswatch is a materialcolor. its different shades of a color a material app will use
      ),
      home: LoginPage(), //sets starting screen
    );
  }

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context) //creates httpclient in context (link to location of a widget in the tree structure of widgets)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true; //sets a callback that will decide whether to accept a secure connection with a server certificate that cannot be authenticated by any of our trusted root certificates
  }
}


