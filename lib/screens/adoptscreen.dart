import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/cat.dart';
import 'package:flutter_application_1/reusable_widgets/reusable_widget.dart';


class AdoptionScreen extends StatelessWidget {

  final List<Cat> _cats=[ //local list of dummy cat objects
    Cat('tabby', 2000, 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000, 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000, 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000, 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000, 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000, 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000, 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000, 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000, 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000, 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000, 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000, 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000, 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
    Cat('tabby', 2000, 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);

    return  Scaffold(
      
      appBar: appBarCustom(context, homeQuery)as PreferredSize,
      //Builds a grid of cat objects with photos
      body: GridView.builder( 
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 4,
            ),
            itemCount: _cats.length,
            itemBuilder: (context, index) {
              return catCard(_cats, index);

            },
          )
    );
  }
}
Widget catCard(cats,index) {
  return SizedBox(
    height: 200,
    child: Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
          elevation: 20,
          margin: const EdgeInsets.all(10),
          child: buildImage(cats[index].image),
    ),
        Text(
      cats[index].name,
      style: const TextStyle(color: Colors.black, fontSize: 15),
      )
      ],
    )
  );
}
//