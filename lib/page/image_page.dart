import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({ Key? key }) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {

  File? _image;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(),
      body : Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              // Pick an image
              final image = await _picker.pickImage(source: ImageSource.gallery);

              if(image != null){
                _image = File(image.path);
              }
              
              print('image $image');
            }, 
          child: const Text('갤러리 사진 가져오기'),
          ),
          ElevatedButton(
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              // Pick an image
              final image = await _picker.pickImage(source: ImageSource.camera);

              if(image != null){
                _image = File(image.path);
              }
              
              print('image $image');
            }, 
          child: const Text('카메라 사진 촬영기'),
          ),
          _image == null ? const Text('empty image') : Image.file(_image!),
        ],
      ),
    );
  }
}