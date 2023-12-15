import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mystore/models/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../request.dart';
import 'home.dart';


class splash extends StatefulWidget{
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {

  request re = new request();
  var app_list;
  @override
  void initState() {
    super.initState();
    data();
    //Start timer to navigate to home page
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:
              (context) => Home(app_list: app_list),
      ));
    }
    );
  }

  void data() async{
    app_list = await re.fetchData();
    print(app_list);
    setState(() {});
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