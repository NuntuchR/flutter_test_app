

import 'package:flutter/material.dart';

///DUMMY USER
class UserModel {
  UserModel({@required this.firstName, @required this.lastName}) {
    //Get avatar text from first letter of first name and last name
    displayText =
        '${firstName.substring(0, 1).toUpperCase()}${lastName.substring(0, 1).toUpperCase()}';
  }
  final String firstName; //user first name
  final String lastName; // user last name
  String displayText; //avatar text
}
