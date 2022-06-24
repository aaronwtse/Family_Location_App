import 'package:aaron_inspiring_quotes/add_friend.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // final List<String> entries = <String>['Aaron', 'Mr. Tran', 'Dr. Sun'];
  // final List<int> colorCodes = <int>[600, 500, 100];

  var friendList = [];

  _ProfilePageState() {
    //load all the friends from firebase and display por favor
    FirebaseDatabase.instance.reference().child("friends").once()
        .then((datasnapshot) {
          print("The data has been loaded and aaron is happy");
          print(datasnapshot);
          var friendTmpList = [];
          datasnapshot.value.forEach((k,v){
            print(k);
            print(v);
            friendTmpList.add(v);
          });
          friendList = friendTmpList;
          setState((){

          });
    }).catchError((error) {
          print("Aaron is not happy");
          print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: ListView.builder( //might display list too long
       itemCount: friendList.length,
         itemBuilder: (BuildContext context, int index) {
           return Container(
               height: 50,
               margin: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
               child: Row(
                 children: [
                   Container(
                     margin: EdgeInsets.only(right: 20),
                     child: const CircleAvatar(
                       backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg'),

                     ),
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                     //left off on video 7:00 #20
                     children: [
                       Text(
                           '${friendList[index]}'
                       ),
                       Text(
                         'k'
                       )
                     ]
                   ),
                   Spacer(),
                   Text('MOBILE')

                 ],
               ),

           );
         }
     ),
       floatingActionButton: FloatingActionButton(
       onPressed: () {
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => AddFriendPage()),
         );
        }
      ),
   );
  }
}
