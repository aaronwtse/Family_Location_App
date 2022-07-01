import 'package:aaron_inspiring_quotes/GPS_Stuff/change_notification.dart';
import 'package:aaron_inspiring_quotes/GPS_Stuff/change_settings.dart';
import 'package:aaron_inspiring_quotes/GPS_Stuff/get_location.dart';
import 'package:aaron_inspiring_quotes/GPS_Stuff/listen_location.dart';
import 'package:aaron_inspiring_quotes/GPS_Stuff/permission_status.dart';
import 'package:aaron_inspiring_quotes/GPS_Stuff/service_enabled.dart';
import 'package:flutter/material.dart';

class TestMapLocation extends StatelessWidget {
  const TestMapLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map Settings"),
        backgroundColor: Color.fromRGBO(0, 0, 128, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            SizedBox(height: 16),
            //PermissionStatusWidget(),
            Divider(height: 32),
            ServiceEnabledWidget(),
            Divider(height: 32),
            GetLocationWidget(),
            Divider(height: 32),
            ListenLocationWidget(),
            Divider(height: 32),
            ChangeSettings(),
            Divider(height: 32),
            ChangeNotificationWidget()
          ],
        ),
      ),
    );
  }
}

