
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessagw extends StatefulWidget {
  const NewMessagw({Key? key}) : super(key: key);

  @override
  State<NewMessagw> createState() => _NewMessagwState();
}

class _NewMessagwState extends State<NewMessagw> {
  final _controller = TextEditingController();
  String _enteredMessage = '';

  _sendMessage()async {
    FocusScope.of(context).unfocus();
    final user =FirebaseAuth.instance.currentUser;
    final userData=await FirebaseFirestore.instance.collection('user').doc(user?.uid).get();
    var content = FirebaseFirestore.instance
        .collection('Chat')
        .add({'content': _enteredMessage,
      'send at': Timestamp.now(),
      'username':userData['username'],
      'userId':user?.uid,
      'userImage':userData['img_url']
        });
    _controller.clear();
    setState(() {
      _enteredMessage='';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                autocorrect: true,
                enableSuggestions: true,
                textCapitalization: TextCapitalization.sentences,
            controller: _controller,
            decoration: const InputDecoration(
                hintText: 'send message ...',
                hintStyle: TextStyle(color: Colors.pink),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink)
                ),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 14)),
            onChanged: (val) {
              setState(() {
                _enteredMessage = val;
              });
            },
          )),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            color: Theme.of(context).primaryColor,
            //focusColor: Colors.green,
            icon: const Icon(
              Icons.send_rounded,
            ),
          )
        ],
      ),
    );
  }
}
