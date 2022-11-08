import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
return Scaffold(
    appBar: AppBar(title: Text('success'),),
  );  }
}

class Unsuccess extends StatelessWidget {
  const Unsuccess({super.key});

  @override
  Widget build(BuildContext context) {
return Scaffold(
    appBar: AppBar(title: Text('unsuccessful'),),
  );  }
}
