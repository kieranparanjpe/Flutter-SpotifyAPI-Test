import 'package:first_flutter_app/Logic/Templates.dart';
import 'package:first_flutter_app/UI/ProfilePageHome.dart';
import 'package:flutter/material.dart';
import 'UI/StatsPageHome.dart';
import 'Logic/SpotifyAPIHandler.dart';


void main(){
  runApp(const MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    loginFromAuthenticator();
    return const MaterialApp(
        title: 'My Title', debugShowCheckedModeBanner: false, home: StatsPageHome());
  }
}

