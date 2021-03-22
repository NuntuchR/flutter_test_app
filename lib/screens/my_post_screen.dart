import 'package:flutter/material.dart';
import 'package:flutter_test_app/components/post_photo.dart';
import 'package:flutter_test_app/models/post_model.dart';
import 'package:flutter_test_app/components/photo_palette.dart';
import 'package:flutter_test_app/models/user_model.dart';
import 'package:flutter_test_app/services/pick_image.dart';
import 'package:flutter_test_app/services/show_popup.dart';
import 'package:flutter_test_app/services/manage_post.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constant.dart';

class MyPostScreen extends StatefulWidget {
  MyPostScreen({Key key}) : super(key: key);

  static const id = 'my_post_screen';

  @override
  _MyPostScreenState createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  PostModel _post = PostModel();
  TextEditingController _textEditingController = TextEditingController();
  bool _isProgressing = false;

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  _isPost
                      ? showActionDialog(context, 'Discard Post?')
                      : Navigator.pop(context);
                }),
            title: Center(
              child: Text('POST'),
            ),
            actions: [],
          ),
          body: ModalProgressHUD(
            inAsyncCall: _isProgressing,
            progressIndicator: CircularProgressIndicator(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          child: Text(user.displayText),
                          backgroundColor: kAvatarColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text('${user.firstName} ${user.lastName}'),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                            color: _isPost ? kEnableColor : Colors.grey,
                          ),
                          onPressed: () async {
                            if (_isPost) {
                              //start spinner
                              setState(() {
                                _isProgressing = true;
                              });

                              //set dummy user as a post user
                              _post.user = user;

                              //add post
                              await addPost(_post).then((value) {
                                //when complete, close MyPost screen
                                Navigator.pop(context);
                              }, onError: ((error, stackTrace) {
                                //if error show error message
                                showErrorDialog(
                                    context, error.toString());
                              }));
                              //clear text field
                              _textEditingController.clear();

                              //stop spinner
                              setState(() {
                                _isProgressing = false;
                              });
                            }
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          icon: Icon(
                            Icons.photo,
                            color: _post.photoWidget.length < MAX_PIC_PER_POST
                                ? kEnableColor
                                : Colors.grey,
                          ),
                          label: Text(
                            'Photo',
                            style: _post.photoWidget.length < MAX_PIC_PER_POST
                                ? kMediumTextBlackStyle
                                : kMediumTextGreyStyle,
                          ),
                          onPressed: () async {
                            await getPhoto(
                                _post, ImageSource.gallery);
                            setState(() {
                              //show selected photos
                              _addPhotoWidget();
                            });
                          },
                        ),
                        TextButton.icon(
                          icon: Icon(
                            Icons.add_a_photo,
                            color: _post.photoWidget.length < MAX_PIC_PER_POST
                                ? kEnableColor
                                : Colors.grey,
                          ),
                          label: Text(
                            'Camera',
                            style: _post.photoWidget.length < MAX_PIC_PER_POST
                                ? kMediumTextBlackStyle
                                : kMediumTextGreyStyle,
                          ),
                          onPressed: () async {
                            await getPhoto(
                                _post, ImageSource.camera);
                            setState(() {
                              //show selected photos
                              _addPhotoWidget();
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      maxLines: null,
                      maxLength: MAX_TEXT_PER_POST,
                      controller: _textEditingController,
                      onChanged: (value) {
                        setState(() {
                          //set text value to post caption
                          _post.caption = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Create a post..',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      child: PhotoPalette(photos: _post.photoWidget),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///Create list of the selected photo while creating post
  ///
  ///
  void _addPhotoWidget() {
    List<Widget> photoWidget = [];
    for (int idx = 0; idx < _post.photoFile.length; idx++) {
      photoWidget.add(
        PostPhoto(
          photo: _post.photoFile[idx],
          onPressed: () {
            _post.photoWidget.removeAt(idx);
            _post.photoFile.removeAt(idx);
            setState(() {});
            _addPhotoWidget();
          },
        ),
      );
      _post.photoWidget = photoWidget;
    }
  }

  ///Check if post is not empty
  ///return true if  caption or photo is exist
  ///otherwise return false
  ///
  bool get _isPost {
    return ((_post.caption != null && _post.caption.isNotEmpty) ||
        _post.photoFile.isNotEmpty);
  }
}
