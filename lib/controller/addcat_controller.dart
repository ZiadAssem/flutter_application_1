import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCatController extends GetxController{
  static AddCatController get instance => Get.find();


  final name = TextEditingController();
  final birthYear = TextEditingController();
  final birthMonth = TextEditingController();
  final type = TextEditingController();
  final color = TextEditingController();
  final image = TextEditingController();

}