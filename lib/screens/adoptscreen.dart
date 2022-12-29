import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/cat.dart';
import 'package:flutter_application_1/reusable_widgets/reusable_widget.dart';
import 'package:flutter_application_1/utils/database.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../classes/request.dart';

class AdoptionScreen extends StatelessWidget {

  
   AdoptionScreen({super.key});

  static Query query = DbHelper.getQuery('cat');
  //Map catMap = await DbHelper.getCats();
  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);
   
    return Scaffold(
      appBar: appBarCustom(context, homeQuery) as PreferredSize,
      //Builds a grid of cat objects with photos
      body: FirebaseAnimatedList(
        query: query,
       itemBuilder:(context, snapshot, animation, index) {
        Map cat = snapshot.value as Map;
        cat['key']=snapshot.key;

        return catCardV2(cat:cat);

       }
       
       ,),
      // GridView.builder(
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisSpacing: 10,
      //       mainAxisSpacing: 10,
      //       crossAxisCount: 4,
      //     ),
          
      //     itemCount: DbHelper.getCatCount(),
      //     itemBuilder: (context, index) {
      //       return catCardV2(cat: catMap);
      //     }
        
      //     ),
    );
  }
}

Widget catCard(cats, index) {
  return SizedBox(
      height: 200,
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 20,
            margin: const EdgeInsets.all(10),
            child: buildImage(cats[index].image),
          ),
          Text(
            cats[index].name,
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
          ElevatedButton(
              onPressed: () {}, child: const Text('Request Adoption'))
        ],
      ));
}

Widget Test(Map cat){
  
  var catName = cat['name'];
  var imageUrl = cat['imageUrl'];
  var catKey = cat['key'];
  return Container(
    child: 
   // catName==null ? Text('The catname is null'):
    Text(catName)
  );
}

Widget catCardV2({required Map cat}) {

  // changes google drive format to an accepted format
  String url = cat['imageUrl'];
  url = url.replaceAll('file/d/', 'uc?export=view&id=');
  url = url.replaceAll('/view?usp=share_link', ' ');

  var catName=cat['name'];

  return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        children: [
          Card(
            child: Column(
              children: [
                SizedBox(
                  height: 240,
                  child: buildImage(url),
                ),
                Text(
                  catName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Request.requestCat(catName);
            }, 
            child: const Text('ADOPT ME <3'))
        ],
      ));
}
