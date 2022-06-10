import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' ;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userProfile;
  var profilePic;
  var username;
  var location;
  var description;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        var uid = user.uid;
        FirebaseDatabase.instance.reference().child("users/" + uid).onValue.listen((event){
          print(event.snapshot.value);
          userProfile = event.snapshot.value;
          setState(() {
            username = userProfile["username"];
            profilePic = userProfile["profilePic"];
            location = userProfile["location"];
            description = userProfile["description"];
          });
        }).onError((error) {
          print("Failed to retrieve user's information");
        }
        );
      }
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdee2fe),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(
                      top: 100,
                      bottom: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 10,
                        ),
                      ],
                      image: const DecorationImage(
                        image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/inspirational-quotes-ed833.appspot.com/o/IMG_4865.jpg?alt=media&token=241a76f3-a48b-46be-9bb1-5a04088d0a3f'),
                      ),
                    ),
                  ),
                  const Text(
                    "Aaron",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "Programmer",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 24,
                  right: 24,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "PROFILE",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 16,),
                    listProfile(Icons.person, "Username", username),
                    listProfile(Icons.date_range, "Date of Birth", "Placeholder"),
                    listProfile(Icons.location_pin, "Location", location),
                    listProfile(Icons.male, "Gender", "Placeholder"),
                    listProfile(Icons.phone, "Phone Number", "Placeholder"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listProfile(IconData icon, String text1, String text2) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(width: 24,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: "Montserrat",
                  fontSize: 14,
                ),
              ),
              Text(
                text2,
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}