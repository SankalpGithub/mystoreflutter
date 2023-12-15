
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/models/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';


class download extends StatefulWidget{
  final String app_name;
  final String app_description;
  final String app_icon_url;
  final List<dynamic> app_images_urls;
  final String app_apk_url;

  download({required this.app_name, required this.app_description, required this.app_icon_url, required this.app_images_urls, required this.app_apk_url});

  @override
  State<download> createState() => _downloadState(app_name, app_description, app_icon_url, app_images_urls, app_apk_url);
}

class _downloadState extends State<download> {
  final String app_name;
  final String app_description;
  final String app_icon_url;
  final List<dynamic> app_images_urls;
  final String app_apk_url;

  _downloadState(this.app_name, this.app_description, this.app_icon_url,
      this.app_images_urls, this.app_apk_url);

  Dio dio = Dio();
  double percent = 0.0;
  bool isLoading = false;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: my_white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: my_black
        ),
        backgroundColor: my_white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
             children: [
          Container(
            margin: EdgeInsets.only(left: 30),
            child: CircleAvatar(
                radius: 30,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(widget.app_icon_url),
            ),
          ),
               Container(
                 margin: EdgeInsets.only(left: 30 , top: 10),
                 child: Text(widget.app_name
                 ,style: TextStyle(
                     fontSize: 20,
                   ),
                 ),
               )
             ],
            ),
            isLoading?Padding(
              padding: const EdgeInsets.only(left: 30,top: 49),
              child: Row(
                children: [
                  LinearPercentIndicator(
                    width: 300.0,
                    lineHeight: 10.0,
                    percent: percent,
                    barRadius: Radius.circular(20),
                    backgroundColor: Colors.grey,
                    progressColor: my_bg,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text((percent*100).toInt().toString()+"%", style: TextStyle(color: my_bg),)
                  ),
                ],
              ),
            ):SizedBox(),

            isClicked?Center(
              child: Container(
                margin: EdgeInsets.only(top: 49),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: my_grey,
                ),
                width: 351,
                height: 54,
                child: Center(
                  child: Text(
                    "DOWNLOAD",
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        color: my_black,
                        letterSpacing: 10
                    ),
                  ),
                ),
              ),
            ):
            Center(
              child: GestureDetector(
                onTap: (){
                  _downloadFile(app_apk_url, app_name);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 49),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: my_bg,
                  ),
                  width: 351,
                  height: 54,
                  child: Center(
                    child: Text(
                      "DOWNLOAD",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            color: my_white,
                            letterSpacing: 10
                          ),
                    ),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 49,left: 10, right: 10),
                child: CarouselSlider(
                  options: CarouselOptions(),
                  items: widget.app_images_urls
                      .map((item) => Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Center(
                        child:
                        Image.network(item, fit: BoxFit.fill, width: 1000,)),
                  ))
                      .toList(),
                )),

            Container(
              margin: EdgeInsets.only(top: 49, right: 10, left: 10),
              child: Text("Description", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            ),

            Container(
              margin: EdgeInsets.all(10),
              child: Text(widget.app_description,
              style: TextStyle(color: my_grey),
              )
            )
          ],
        ),
      )
    );
  }

  void _downloadFile(String url, String fileName) async {// Replace with your file URL
    final appDirectory = await getExternalStorageDirectory();
    final filePath = '${appDirectory?.path}/$fileName.apk'; // Replace with your desired save path
    File file = File(filePath);
    if (await file.exists()) {
      Fluttertoast.showToast(msg: 'file already downloded');
    }else{
      setState(() {
        isLoading = true;
        isClicked = true;
      });
      try {
        await dio.download(
          url,
          filePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              setState(() {
                percent = (received / total);
              });
            }
          },
        );
        setState(() {
          isLoading = false;
          isClicked  = false;
          Fluttertoast.showToast(msg: "download completed");
        });
      } catch (e) {
        print('Error: $e');
      }
    }
  }
}