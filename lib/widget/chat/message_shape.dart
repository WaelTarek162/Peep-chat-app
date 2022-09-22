import 'package:flutter/material.dart';

class Message_shape extends StatelessWidget {


  final Key key;
  final String message;
  final String username;
  final bool isMe;
  final String userImg;

  Message_shape( this.message, this.username, this.isMe,this.userImg, this.key);

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,
          children: [
            if(!isMe)
              SizedBox(child: CircleAvatar(backgroundImage: NetworkImage(userImg),)),
            Container(
              decoration: BoxDecoration(
                color: isMe?Theme.of(context).primaryColor:Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomLeft: !isMe?Radius.circular(0):Radius.circular(14),
                  bottomRight: isMe?Radius.circular(0):Radius.circular(14),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
              child: Column(
                crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
                children: [
                  Text(message,style:TextStyle(color: !isMe?Colors.black:Colors.white),),
                ],
              ),
            ),
            if(isMe)
              SizedBox(child: CircleAvatar(backgroundImage: NetworkImage(userImg),)),

          ],
        );
  }
}
