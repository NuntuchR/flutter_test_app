import 'package:flutter/material.dart';
import 'package:flutter_test_app/screens/my_feed_screen.dart';


  ///Show dialog to confirm user action
  ///
  ///
  Future<void> showActionDialog(
      BuildContext context, String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(content),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName(MyFeedScreen.id));
                  },
                ),
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  ///Show error dialog
  ///
  ///
  Future<void> showErrorDialog(BuildContext context, String content) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  ///Show only selected [photo] on screen
  ///
  ///
  Future<void> showFullPhoto(BuildContext context, Widget photo) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: photo,
          contentPadding: EdgeInsets.all(10.0),
          insetPadding: EdgeInsets.all(10.0),
        );
      },
    );
  }
