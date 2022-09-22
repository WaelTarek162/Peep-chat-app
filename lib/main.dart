import 'package:chat_application/screens/auth_screen.dart';
import 'package:chat_application/screens/chat_screen.dart';
import 'package:chat_application/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter demo',
      theme: ThemeData(
          backgroundColor: Colors.pink,
        //  scaffoldBackgroundColor: Colors.pink,

          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink, textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          primaryColor: Colors.pink,
          colorScheme: ColorScheme.fromSwatch(
              backgroundColor: Colors.white,
              primarySwatch: Colors.pink,
              accentColor: Colors.deepPurple,
              brightness: Brightness.light)),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges() ,builder:(ctx,snapshot){

        if(snapshot.connectionState==ConnectionState.waiting)
          return Splash_screen();
        if(snapshot.hasData){
          return Chat_screen();
        }else{
          return Auth_screen();
        }
      } ,),
    );
  }
}
