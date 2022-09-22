import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class User_img_picker extends StatefulWidget {

  final void Function(File _picked_img)imgPickfn;

  User_img_picker({required this.imgPickfn});

  @override
  State<User_img_picker> createState() => _User_img_pickerState();
}

class _User_img_pickerState extends State<User_img_picker> {


  File? _picked_img;
  final ImagePicker _picker = ImagePicker();

  void _pick_img(ImageSource src) async {
    final picked_img_file = await _picker.pickImage(source: src,imageQuality: 50,maxWidth: 150);
    if (picked_img_file != null) {
      setState(() {
        _picked_img = File(picked_img_file.path);
      });
      widget.imgPickfn(_picked_img!);
    } else {
      print('no image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _picked_img != null ? FileImage(_picked_img!) : null,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              style: ButtonStyle(backgroundColor:MaterialStatePropertyAll( Colors.white)),
              onPressed: () => _pick_img(ImageSource.camera),
              icon: Icon(Icons.photo_camera_outlined,color: Theme.of(context).primaryColor),
              label: Text('Add image\nFrom Camera',style: TextStyle(color: Theme.of(context).primaryColor,),),
            ),
            const SizedBox(width: 2,),
            ElevatedButton.icon(
              style: ButtonStyle(backgroundColor:MaterialStatePropertyAll( Colors.white)),
              onPressed: () => _pick_img(ImageSource.gallery),
              icon: Icon(Icons.image_rounded,color: Theme.of(context).primaryColor,),
              label: Text('Add image\nFrom Gallery',style: TextStyle(color: Theme.of(context).primaryColor,),),
            )
          ],
        )
      ],
    );
  }
}
