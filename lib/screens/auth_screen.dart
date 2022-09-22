import 'dart:io';
import 'package:chat_application/widget/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth_screen extends StatefulWidget {
  @override
  State<Auth_screen> createState() => _Auth_screenState();
}

class _Auth_screenState extends State<Auth_screen> {
  final _auth = FirebaseAuth.instance;

  bool _isloading = false;

  void _submitAuthForm(String email, String pass, String userName, bool islogin, File? img,
      BuildContext ctx) async {
    UserCredential authResult;
    try {
      setState(() {
        _isloading=true;
      });

      if (islogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: pass);
////////////
        final ref=FirebaseStorage.instance.ref().child('user_img').child('${authResult.user?.uid}'+'.jpg');

        final url =await ref.getDownloadURL();
        print('url is $url');

        img=File.fromUri(Uri.parse(url));
/////////////

      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: pass);

        final ref=FirebaseStorage.instance.ref().child('user_img').child('${authResult.user?.uid}'+'.jpg');

        await ref.putFile(img!);
        final url =await ref.getDownloadURL();
        print('url is $url');
        await FirebaseFirestore.instance.collection('user').doc(authResult.user?.uid).set(
            {
              'username':userName,
              'password':pass,
              'img_url' :url
            });


      }
    } catch (e) {
      print('hereee');
      print(e);
      var content =e.toString().split(']') ;
      print(content);
      Fluttertoast.showToast(
          msg: "${content[1]}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      setState(() {
        _isloading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Auth_form(_submitAuthForm,_isloading));
  }
}
