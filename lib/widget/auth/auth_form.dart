import 'dart:io';
import 'package:chat_application/widget/picker/user_img_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth_form extends StatefulWidget {
  final void Function(String email, String pass, String userName, bool islogin,File? img,
      BuildContext ctx) submitAuthForm;

  bool is_loading;

  Auth_form(this.submitAuthForm, this.is_loading);

  @override
  State<Auth_form> createState() => _Auth_formState();
}

class _Auth_formState extends State<Auth_form> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _userName = '';
  File? _userimg;

  void _pick_img(File picked_img){
    _userimg=picked_img;

  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if( _userimg==null && !_isLogin ){
      Fluttertoast.showToast(
          msg: "Please Choose Image profile!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }
    if (isValid!) {
      _formKey.currentState?.save();
      print(_email);
   /*   var db = FirebaseFirestore.instance;
      final user = db.collection("user");
      var us=user.where('username',isEqualTo: 'tttt').get().then(
            (res) => print("Successfully completed ${res.}"),
        onError: (e) => print("Error completing: $e"),
      );*/

     // print(us['password']);
      if(_isLogin){
      widget.submitAuthForm(
          _email.trim(), _password.trim(), _userName.trim(), _isLogin,null ,context);}
      else{
        widget.submitAuthForm(
            _email.trim(), _password.trim(), _userName.trim(), _isLogin,_userimg! ,context);
      }
      print(_email);
      print(_password);
      print(_userName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if(!_isLogin)
                    User_img_picker(imgPickfn: _pick_img),

                  TextFormField(
                    autocorrect: false,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.none,
                    key: ValueKey('email'),
                    validator: (val) {
                      if (val.toString() == 'null' ||
                          !val.toString().contains('@')) {
                        return "Please Enter a valid email address";
                      }
                      return null;
                    },
                    onSaved: (val) => _email = val!,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(label: Text('Email Address')),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      autocorrect: true,
                      enableSuggestions: true,
                      textCapitalization: TextCapitalization.words,
                      key: ValueKey('username'),
                      validator: (val) {
                        if (val.toString() == 'null' ||
                            val.toString().length < 4) {
                          return "Please Enter at least 4 characters";
                        }
                        return null;
                      },
                      onSaved: (val) => _userName = val!,
                      decoration:
                          const InputDecoration(label: Text('Username')),
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (val) {
                      if (val.toString() == 'null' ||
                          val.toString().length < 7) {
                        return "Password must be at least 7 characters";
                      }
                      return null;
                    },
                    onSaved: (val) => _password = val!,
                    decoration: const InputDecoration(label: Text('Password')),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.is_loading)
                    CircularProgressIndicator(),
                  if (!widget.is_loading)
                    ElevatedButton(
                        onPressed: _submit,
                        child: Text(
                          _isLogin ? 'Login' : 'Sign Up',
                        )),
                  if (!widget.is_loading)
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'I already have account'))
                ],
              )),
        ),
      ),
    );
  }
}
