import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_application_1/reusable_widgets/reusable_widget.dart';
//import 'package:file_picker/file_picker.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  ScrollController scrollController = ScrollController();
  final urlImages = [
    // list of dummy images
    'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg',
    'https://icatcare.org/app/uploads/2018/07/Thinking-of-getting-a-cat.png'
  ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);

    return Flexible(
      child: Scaffold(
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
                slideShow(homeQuery),
                Container(margin: const EdgeInsets.only(top: 25.0)),
                buildIndicator(),
                Container(margin: const EdgeInsets.only(top: 25.0)),
                Container(margin: const EdgeInsets.only(top: 25.0)),
                aboutUs(),
              ],
            ),
          )),
    );
  }

// generates slideshow of images
  Widget slideShow(homeQuery) {
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
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
      );
}

// About us info to be included
Widget aboutUs() {
  return Container(
    child: Center(child: Text("About Us")),
  );
}
