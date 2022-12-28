import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/cat.dart';
import 'package:flutter_application_1/reusable_widgets/reusable_widget.dart';
import 'package:flutter_application_1/utils/database.dart';

class AdoptionScreen extends StatelessWidget {
  final List<Cat> _cats = [
    //local list of dummy cat objects
    Cat('tabby', 2000,
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000,
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000,
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000,
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000,
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000,
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000,
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000,
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000,
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000,
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000,
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000,
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000,
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000,
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
  ];

  AdoptionScreen({super.key});
  static Query ref = DbHelper.getQuery('cat');
  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: appBarCustom(context, homeQuery) as PreferredSize,
      //Builds a grid of cat objects with photos
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 4,
          ),
          itemBuilder: (context, index) {
            return FirebaseAnimatedList(
                query: ref,
                itemBuilder: ((context, snapshot, animation, index) {
                  Map cat = snapshot.value as Map;
                  cat['key'] = snapshot.key;

                  return catCardV2(cat: cat);
                }));
          }
          //       },
          //     )
          ),
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

Widget catCardV2({required Map cat}) {
  // changes google drive format to an accepted format
  String url = cat['imageUrl'];
  url = url.replaceAll('file/d/', 'uc?export=view&id=');
  url = url.replaceAll('/view?usp=share_link', ' ');
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
                  cat['name'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text('ADOPT ME <3'))
        ],
      ));
}
