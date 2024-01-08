import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../pages/home.dart';

class connectivity extends StatefulWidget{
  @override
  State<connectivity> createState() => _connectivityState();
}

class _connectivityState extends State<connectivity> {
  bool _isOnline = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      print("you are offline");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: Icon(Icons.offline_bolt, size: 50,)
            ),
            Text("You are Offline"),
            ElevatedButton(onPressed: (){
              CheckUserConnection();
            }, child: Text("Refrash"))
          ],
        ),
      ),
    );
  }
}

