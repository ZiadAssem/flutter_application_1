import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/cat.dart';
import 'package:flutter_application_1/reusable_widgets/reusable_widget.dart';
import 'package:flutter_application_1/utils/database.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../classes/request.dart';

class AdoptionScreen extends StatefulWidget {
  const AdoptionScreen({super.key});

  @override
  State<AdoptionScreen> createState() => _AdoptionScreenState();
}

class _AdoptionScreenState extends State<AdoptionScreen> {
  static Query query = DbHelper.getQuery('cat');
  //Map catMap = await DbHelper.getCats();
  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);

    return Scaffold(
        appBar: appBarCustom(context, homeQuery) as PreferredSize,
        //Builds a grid of cat objects with photos
        body: Stack(
          children: [
          Container(
            decoration: const BoxDecoration(
             
              color: Colors.deepPurple,
              //Color(0xff69539C),
            ),
          ),
          FirebaseAnimatedList(
            query: query,
            itemBuilder: (context, snapshot, animation, index) {
              
              Map cat = snapshot.value as Map;
              cat['key'] = snapshot.key;

              return Row(
                children:[
                  Expanded(
                child:
                  catCardV2(homeQuery, cat: cat),
                  ),
                  Container(width: homeQuery.size.width*0.3,)
                ]
               ,
               ) ;
              
            },
          )
        ]
    
            ));
  }
}




Widget catCardV2(homeQuery, {required Map cat}) {

  // changes google drive format to an accepted format
  String url = cat['imageUrl'];
  url = url.replaceAll('file/d/', 'uc?export=view&id=');
  url = url.replaceAll('/view?usp=share_link', ' ');
  
  var catKey = cat['key'];
  var catName = cat['name'];
  var birthYear = cat['birthYear'];
  var color = cat['color'];
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    elevation: 15,
    child:SizedBox(
      width: homeQuery.size.width*0.6,
      child: Row(
      children: [
        Column(
          children: [
            SizedBox(
              width: homeQuery.size.width*0.1,
            child:buildRequestImage(url, homeQuery),
            ),
            SizedBox(width: homeQuery.size.width * 0.4,),
            Text(
              catName,
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            
          ],
        ),
        Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('BIRTH YEAR: $birthYear'), Text('COLOR: $color')],
        ),
        SizedBox(width: homeQuery.size.width*0.01,),
        ElevatedButton(onPressed: (){Request.requestCat(catName,catKey);}, child: const Text('Adopt Me <3'))
      ],
    ),
  )
  );
}
