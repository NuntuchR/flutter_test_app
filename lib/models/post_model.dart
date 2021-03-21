import 'dart:io';

import 'package:flutter/material.dart';

import 'user_model.dart';

class PostModel {
  String id; //document reference
  UserModel user; //post user
  String caption; //post caption
  List<File> photoFile = []; //selected photo file
  List<Widget> photoWidget = []; //selected photo file
  List<String> photoURL = []; //reference url for post photo on Storage
  String timeStamp; //post timestamp
}
