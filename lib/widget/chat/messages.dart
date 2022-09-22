
import 'package:chat_application/widget/chat/message_shape.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
    stream:FirebaseFirestore.instance.collection('Chat').orderBy('send at',descending: true).snapshots() ,
        builder: (ctx,snapshot){
      if(snapshot.connectionState==ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }else{
        final docs= snapshot.data?.docs;
        final Uid=FirebaseAuth.instance.currentUser?.uid;
        return ListView.builder(
            itemCount: docs?.length,
            reverse: true,
            itemBuilder: (ctx,index)=>Message_shape(
             docs![index]['content'],
              docs![index]['username'],
              docs![index]['userId']==Uid,
              docs![index]['userImage'],
              ValueKey(docs[index].id)
            ));
      }
    });
  }
}
