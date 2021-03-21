import 'package:flutter/material.dart';
import 'package:flutter_test_app/components/post_feed.dart';
import 'package:flutter_test_app/models/user_model.dart';
import '../constant.dart';
import 'my_post_screen.dart';

class MyFeedScreen extends StatefulWidget {
  MyFeedScreen({Key key}) : super(key: key);

  static const id = 'my_feed_screen';

  @override
  _MyFeedScreenState createState() => _MyFeedScreenState();
}

class _MyFeedScreenState extends State<MyFeedScreen> {
  UserModel _dummyUser = UserModel(firstName: 'First', lastName: 'Last');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(child: Text('MY FEED'),),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    child: Text(_dummyUser.displayText),
                    backgroundColor: kAvatarColor,
                  ),
                  Text('${_dummyUser.firstName} ${_dummyUser.lastName}'),
                  IconButton(
                      icon: Icon(
                        Icons.post_add,
                        color: kEnableColor,
                      ),
                      onPressed: () {
                        //Navigate to MyPost screen
                        Navigator.pushNamed(context, MyPostScreen.id, arguments: _dummyUser);
                      })
                ],
              ),
            ),
            PostFeed(),
          ],
        ),
      ),
    );
  }
}
