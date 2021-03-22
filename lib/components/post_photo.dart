import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/services/show_popup.dart';

class PostPhoto extends StatelessWidget {
  PostPhoto({@required this.photo, @required this.onPressed});
  final File photo;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap:(){
          showFullPhoto(context, Image.file(
            photo,
          ),);
        },
        child: Image.file(
          photo,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: onPressed ),
        ],
      ),
    ]);
  }
}
