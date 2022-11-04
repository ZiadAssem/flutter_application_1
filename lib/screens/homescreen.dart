import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_1/screens/loginscreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  final urlImages = [
    // list of images
    'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x1.jpg',
    'https://icatcare.org/app/uploads/2018/07/Thinking-of-getting-a-cat.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: homeButton(context),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Row(
              children: [
                loginButton(context),
                Container(padding: const EdgeInsets.all(10)),
              ],
            ),
          ],
          backgroundColor: const Color(0xff69539C),
        ),
        body: Column(
          children: [
            Container(margin: const EdgeInsets.only(top: 50.0)),
            slideShow(),
            Container(margin: const EdgeInsets.only(top: 25.0)),
            buildIndicator(),
          ],
        ));
  }

  Widget buildImage(String urlImage, int index) => Container(
        //builds image

        margin: const EdgeInsets.symmetric(horizontal: 2),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );

  Widget slideShow() {
    //generates slideshow of images
    return Center(
      child: CarouselSlider.builder(
        options: CarouselOptions(
            height: 400,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: ((index, reason) => setState(() {
                  activeIndex = index;
                }))),
        itemCount: urlImages.length,
        itemBuilder: ((context, index, realIndex) {
          final urlImage = urlImages[index];
          return buildImage(urlImage, index);
        }),
      ),
    );
  }

  Widget loginButton(context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
      child: const Text(
        "LOGIN",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget homeButton(context) {
    return IconButton(
      icon: Image.asset('assets/download2.png'),
      iconSize: 50,
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
      },
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
      );
}
