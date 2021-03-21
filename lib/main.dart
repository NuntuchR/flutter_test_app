import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_test_app/screens/my_feed_screen.dart';
import 'package:flutter_test_app/screens/my_post_screen.dart';
import 'package:flutter_test_app/services/manage_post.dart';

import 'constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize firebase app
  await initFirebase();

  //initialize orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue.shade200);
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
        primaryColor: Colors.blue.shade200,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
            bodyText2: kMediumTextBlackStyle, button: kMediumTextBlackStyle),
      ),
      home: MyFeedScreen(),
      initialRoute: MyFeedScreen.id,
      routes: {
        MyFeedScreen.id: (context) => MyFeedScreen(),
        MyPostScreen.id: (context) => MyPostScreen(),
      },
    );
  }
}
