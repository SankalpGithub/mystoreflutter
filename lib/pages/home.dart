import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystore/models/colors.dart';
import 'package:mystore/pages/download.dart';
import 'package:shimmer/shimmer.dart';


class Home extends StatefulWidget {
  final List? app_list;
  Home({
  super.key,
  required this.app_list,});
  @override
  State<Home> createState() => myhomepage(app_list: app_list);
}

class myhomepage extends State<Home> {
  final List? app_list;
  myhomepage({
    required this.app_list,
  });
  List? search_app_list;
  bool connction = false;
  @override
  void initState(){
    super.initState();
    search_app_list = app_list;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Column(
          children: [
            downAppbar(),
       Expanded(child: main_body(app_list: search_app_list!)),
          ],
        )

    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: my_bg,
      title: Container(
        child: Text(
          "MY STORE",
          style: GoogleFonts.koulen(
              fontSize: 20, letterSpacing: 5, color: my_white),
        ),
      ),
    );
  }

  Container downAppbar() {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 120,
      decoration: BoxDecoration(
        color: my_bg,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(52.0),
            bottomRight: Radius.circular(52.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey, // Shadow color
            blurRadius: 4, // Spread of the shadow
            offset: Offset(0, 3), // Offset of the shadow (horizontal, vertical)
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 38),
        child: Container(
          padding: EdgeInsets.only(left: 15, bottom: 3),
          height: 43,
          width: 298,
          decoration: BoxDecoration(
              color: my_white,
              borderRadius: BorderRadius.all(Radius.circular(52))),
          child: TextField(
            onChanged: (value) => runFilter(value),
            decoration: InputDecoration(
              border: InputBorder.none, // Remove the default border
              hintText: 'Search',
              suffixIcon: Container(
                  child: Icon(
                Icons.search,
                color: my_bg,
              )),
            ),
          ),
        ),
      ),
    );
  }

  runFilter(String keywords) {
    List? result = [];
    if (keywords.isEmpty) {
      result = app_list;
    } else {
      for(int i = 0;i < (app_list!.length) ;i++){
        if(app_list![i]['app_name'].toLowerCase().contains(keywords.toLowerCase())){
          result.add(app_list![i]);
        }
      }
    }
    setState(() {
      search_app_list = result;
    });
  }
}

class main_body extends StatelessWidget {
  const main_body({
    super.key,
    required this.app_list,
  });

  final List? app_list;

  @override
  Widget build(BuildContext context) {
    if(app_list != null){
    return Container(
     margin: EdgeInsets.only(top: 30, left: 20, right: 20),
     height: MediaQuery
         .of(context)
         .size
         .height * 0.66,
     width: MediaQuery
         .of(context)
         .size
         .width * 1,
     // color: my_bg,
     child: GridView.builder(
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 3,
       ),
       itemCount: app_list!.length,
       itemBuilder: (context, index) {
         final app = app_list![index];
         return GestureDetector(
           onTap: () {
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) =>
                   download(app_name: app['app_name'],
                       app_description: app['app_description'],
                       app_icon_url: app['app_icon_url'],
                       app_images_urls: app['app_images_urls'],
                       app_apk_url: app['app_apk_url']),
               ),
             );
           },
           child: GridTile(
             child: Column(
               children: [
                 Image.network(
                   app['app_icon_url'],
                   width: 60.0, // Adjust the image width as needed
                   height: 68.0, // Adjust the image height as needed
                 ),

                 SizedBox(height: 8.0), // Add spacing between image and text
                 Text(app['app_name']),
               ],
             ),
           ),
         );
       },
     ),
      );
    }else{
      return  Container(
        margin: EdgeInsets.only(top: 30, left: 20, right: 20),
        height: MediaQuery
            .of(context)
            .size
            .height * 0.66,
        width: MediaQuery
            .of(context)
            .size
            .width * 1,
        // color: my_bg,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return GridTile(
              child: Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                      width: 60.0, // Adjust the image width as needed
                      height: 68.0, // Adjust the image height as needed
                    ),
                  ),

                SizedBox(height: 8.0), // Add spacing between image and text
                   Shimmer.fromColors(
                       baseColor: Colors.grey[300]!,
                       highlightColor: Colors.grey[100]!,
                       child: Container(
                         color: Colors.white,
                         width: 60,
                         height: 10,
                       ),
                   ),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}
