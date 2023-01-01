import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_application_1/model/database.dart';
import 'package:flutter_application_1/view/reusable_widgets/reusable_widget.dart';

import '../classes/cat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData homeQuery = MediaQuery.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          scrollController.animateTo(500,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        },
        child: const Icon(Icons.arrow_downward),
      ),
      appBar: appBarCustom(context, homeQuery, Container()),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Container(margin: const EdgeInsets.only(top: 50.0)),
            slideshow(homeQuery),
            Container(margin: const EdgeInsets.only(top: 100.0)),
            // buildIndicator(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
                  child: aboutUs(homeQuery),
                ),
                SizedBox(width: homeQuery.size.width * 0.05),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      emergencyContact(homeQuery),
                      SizedBox(height: homeQuery.size.height * 0.05),
                      joinUs(homeQuery),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // generates slideshow of images
  Widget slideshow(homeQuery) {
    return FutureBuilder(
      future: DbHelper.getImageUrlFromFirebase(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          //final urlImageList = List<String>.from(snapshot.data?.value as List);
          return Column(
            children: [
              customCarousel(homeQuery, Cat.urlImages),
              Container(margin: const EdgeInsets.only(top: 50.0)),
              buildIndicator(Cat.urlImages),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

// Animation for slideshow
  Widget buildIndicator(List urlImages) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
      );

// Text for the about us section
  Widget aboutUs(homeQuery) {
    return Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: homeQuery.size.width * 0.5,
          child: Column(
            children: const [
              Text("About Us",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Text(
                'Animal Rights Association is a non-profit organization that operates within the American University in Cairo (AUC) was founded in AUC in 2017. ARA aims to make a difference in the community, by increasing public awareness of animal welfare in Egypt and reducing cruelty towards animals. This is done by various projects, which include cats on campus, awareness campaigns, and supporting animal shelters. The club faces some problems as they need to reach more amount of people and make some actions easier to happen with a well developed website'
                ' We have developed some solutions for the club to make the club more findable and to ease some actions made by the customers who wants to adopt or rescue cats most importantly, we provide the training and support for this new solution that ensures the staff can ramp up quickly and realize our improvements to their services.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ));
  }

  // responsible for moving the images of slideshow
  Widget customCarousel(homeQuery, List<String> urlList) {
    return CarouselSlider(
      options: CarouselOptions(
        height: homeQuery.size.height * 0.7,
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        onPageChanged: (index, reason) => setState(() {
          activeIndex = index;
        }),
      ),
      items: imageSliders(urlList),
    );
  }
}

// Button that opens the emergency contact snackbar
Widget emergencyContact(homeQuery) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(homeQuery.size.width * 0.4, 50),
        maximumSize: Size(homeQuery.size.width * 0.4, 50),
        backgroundColor: Colors.red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      onPressed: () {
        Get.showSnackbar(GetSnackBar(
          message: 'EMERGENCY CONTACT',
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          margin: const EdgeInsets.all(8),
          borderRadius: 8,
          icon: const Icon(Icons.warning_amber_outlined),
          mainButton: TextButton(
            onPressed: () {},
            child: const Text('UNDO'),
          ),
        ));
      },
      child: const Text(
        'EMERGENCY CONTACT',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ));
}

// Button that opens the join us form
Widget joinUs(homeQuery) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size(homeQuery.size.width * 0.4, 50),
      maximumSize: Size(homeQuery.size.width * 0.4, 50),
      backgroundColor: Colors.deepPurple,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    onPressed: () {
      launch(
          'https://docs.google.com/forms/d/e/1FAIpQLSeShHTu7iZvSj8lguZ0asfwiK9q0fg6p5P7JNNRsAWkno1ZEg/formrestricted');
    },
    child: const Text(
      'JOIN US',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}

// generates the images of the slideshow as a list
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

// builds the images from the links in the database
Widget buildImageFromMap(url, [homeQuery]) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 2),
    color: Colors.grey,
    child: Image.network(
      url,
      fit: BoxFit.cover,
    ),
  );
}
