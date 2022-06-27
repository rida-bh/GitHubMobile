import 'package:flutter/material.dart';
import 'package:git_hub_mobile_app/UI/pages/home/home.page.dart';
import 'package:git_hub_mobile_app/UI/pages/users/users.page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      routes: {
        "/":(context)=>HomePage(),
        "/users":(context)=>UserPage(),
      },

      initialRoute: "/users",
    );
  }
}


