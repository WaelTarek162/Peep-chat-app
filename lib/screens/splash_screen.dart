import 'package:flutter/material.dart';

class Splash_screen extends StatelessWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: const Center(
        child: Text('Loading...',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
      ),
    );
  }
}
