import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/components/post_template.dart';

class PostFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        QuerySnapshot querySnapshot = snapshot.data;
        return Expanded(
          child: ListView.builder(
            itemCount: querySnapshot.size,
            itemBuilder: (context, index) =>
                PostTemplate(snapshot: querySnapshot.docs[index]),
          ),
        );
      },
    );
  }
}
