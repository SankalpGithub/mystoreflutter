import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mystore/models/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystore/models/connectivity.dart';
import 'package:shimmer/shimmer.dart';
import 'home.dart';
import 'package:http/http.dart' as http;


class splash extends StatefulWidget{
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  bool _isOnline = false;
  @override
  void initState() {
    super.initState();
    CheckUserConnection();
  }
  Future CheckUserConnection() async {
      try {
        final response = await http.get(Uri.parse("https://www.google.com"));
        if (response.statusCode == 200) {
          setState(() {
            _isOnline = true;
          });
        }else{
          setState(() {
            _isOnline = false;
          });
        }
      }catch (e) {
        setState(() {
          _isOnline = false;
        });
      }
    if(_isOnline == true){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:
              (context) => Home(),
          ));
    }else if (_isOnline == false){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:
              (context) => connectivity(),
          ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1,  // 80% of screen width
        height: MediaQuery.of(context).size.height * 1,
        padding: EdgeInsets.only(top: 350, left: 120),
        child: Shimmer.fromColors(
          baseColor: my_white,
          highlightColor: my_bg,
          child: Text("MY STORE",
          style: GoogleFonts.koulen(
            fontSize: 30,
            letterSpacing: 10,
              color: my_white
          ),
          ),
        ),
        color: my_bg,
      ),
    );
  }
}