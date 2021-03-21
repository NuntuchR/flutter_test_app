import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/components/photo_palette.dart';
import 'package:flutter_test_app/services/show_popup.dart';
import 'package:flutter_test_app/services/manage_post.dart';

import '../constant.dart';

class PostTemplate extends StatelessWidget {
  PostTemplate({@required this.snapshot});
  final QueryDocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                      child: CircleAvatar(
                        child: Text(_post['user']['displayText']),
                        backgroundColor: kAvatarColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_post['user']['firstname']} ${_post['user']['lastname']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _post['timestamp'],
                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                        )
                      ],
                    ),
                    Expanded(child: Container()),
                    Visibility(
                      visible: _post['id'] != null,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            icon: Icon(
                              Icons.close,
                            ),
                            onPressed: () async {
                              await deletePost(
                                _post['id'],
                                _post['photos'],
                              ).onError((error, stackTrace) =>
                                  ShowPopup.showErrorDialog(
                                      context, error.toString()));
                            }),
                      ),
                    ),
                  ],
                ),
                Text(
                  _post['caption'] ?? '',
                  style: kMediumTextBlackStyle,
                ),
                //IMAGE DUMMY
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: PhotoPalette(photos: _fullPhoto(context, _photos)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///get snapshot data
  ///
  ///
  Map<String, dynamic> get _post {
    return snapshot.data();
  }

  ///get photo widget form the reference url
  ///
  ///
  List<Widget> get _photos {
    List<Widget> photoList = [];
    for (var url in _post['photos']) {
      photoList.add(Image.network(url));
    }
    return photoList;
  }

  ///Create widget list to view full photo of the post
  ///
  ///
  List<Widget> _fullPhoto(BuildContext context, List<Widget> photos) {
    List<Widget> fullPhoto = [];
    for (var photo in photos) {
      fullPhoto.add(GestureDetector(
        onTap: () {
          ShowPopup.showFullPhoto(context, photo);
        },
        child: photo,
      ));
    }
    return fullPhoto;
  }
}
