import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_1/utils/database.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_application_1/reusable_widgets/reusable_widget.dart';
//import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../classes/cat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  ScrollController scrollController = ScrollController();
  // final urlImages = [
  //   // list of dummy images
  //   'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg',
  //   'https://icatcare.org/app/uploads/2018/07/Thinking-of-getting-a-cat.png'
  // ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        scrollController.animateTo(500,
            duration: const Duration(seconds: 1), curve: Curves.easeIn);
      }),
      appBar: appBarCustom(context, homeQuery),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Container(margin: const EdgeInsets.only(top: 50.0)),
            slideShow2(homeQuery),
            Container(margin: const EdgeInsets.only(top: 25.0)),
            // buildIndicator(),
          ],
        ),
      ),
    );
  }

  Widget slideShow2(homeQuery) {
    return FutureBuilder(
      future: DbHelper.getImageUrlFromFirebase(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          //final urlImageList = List<String>.from(snapshot.data?.value as List);
          return customCarousel(homeQuery, Cat.urlImages);
        } else {
          return Text('Error');
        }
      },
    );
  }

// generates slideshow of images
  Widget slideShow(homeQuery, List urlImages) {
    return Center(
      child: Expanded(
        child: CarouselSlider.builder(
          options: CarouselOptions(
              height: 0.7 * homeQuery.size.height,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: ((index, reason) => setState(() {
                    activeIndex = index;
                  }))),
          itemCount: urlImages.length,
          itemBuilder: ((context, index, realIndex) {
            final urlImage = urlImages[index];
            return buildImage(urlImage);
          }),
        ),
      ),
    );
  }

// Animation for slideshow
  Widget buildIndicator(List urlImages) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
      );

// About us info to be included
  Widget aboutUs() {
    return Container();
  }

  Widget AnimatedList() {
    Query ref = DbHelper.getQuery('imageUrl');
    return FirebaseAnimatedList(
      query: ref,
      itemBuilder: ((context, snapshot, animation, index) {
        Map urlMap = snapshot.value as Map;

        urlMap['key'] = snapshot.key;

        return buildImageFromMap(urlMap);
      }),
    );
  }

  Widget customCarousel(homeQuery, List<String> urlList) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
      ),
      items: imageSliders(urlList),
    );
  }
}

List<Widget> imageSliders(List<String> imgList) => imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Center(child: buildImageFromMap(item))),
          ),
        ))
    .toList();

Widget buildImageFromMap(url, [homeQuery]) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 2),
    //width:homeQuery==Null?Null: homeQuery.size.width *0.3,
    color: Colors.grey,
    child: Image.network(
      url,
      fit: BoxFit.cover,
    ),
  );
}
