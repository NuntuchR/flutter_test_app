import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test_app/models/post_model.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

Future<void> initFirebase() async {
  await Firebase.initializeApp();
}

///Add post and image to firebase cloud storage and Storage
///
///
Future<void> addPost(PostModel post) async {
  post.photoURL = await _uploadImageToFirebaseStorage(post);
  post.id = await _addPostToFirebaseFireStore(post);
  await _updatePostPhotoToFirebaseFireStore(post);
}

///Upload image to Storage to retrieve reference URL [imageURL]
///
///
Future<List<String>> _uploadImageToFirebaseStorage(PostModel post) async {
  List<String> imageURL = [];
  String downloadUrl;
  File photo;
  for (int index = 0; index < post.photoFile.length; index++) {
    photo = post.photoFile[index];
    String fileName = basename(photo.path);
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref('post_photos/$fileName')
        .putFile(photo)
        .onError((error, stackTrace) async {
      await _removeImageFromFirebaseStorage(imageURL);
      throw error;
    });
    downloadUrl = await taskSnapshot.ref
        .getDownloadURL()
        .onError((error, stackTrace) async {
      await _removeImageFromFirebaseStorage(imageURL);
      throw error;
    });
    imageURL.add(downloadUrl);
  }

  return imageURL;
}

///Add [post] to firebase cloud storage
///
///
Future<String> _addPostToFirebaseFireStore(PostModel post) async {
  String docRefString;
  final format = DateFormat('dd/MM/yyyy HH:mm:ss');
  DocumentReference documentReference =
      await FirebaseFirestore.instance.collection('posts').add({
    'id': post.id,
    'user': {
      'firstname': post.user.firstName,
      'lastname': post.user.lastName,
      'displayText': post.user.displayText
    },
    'caption': post.caption,
    'photos': post.photoURL,
    'timestamp': format.format(DateTime.now())
  }).onError((error, stackTrace) async {
    await _removeImageFromFirebaseStorage(post.photoURL);
    throw error;
  });

  docRefString = documentReference.toString();
  docRefString = docRefString.substring(
      docRefString.indexOf('/') + 1, docRefString.length - 1);
  return docRefString;
}

///Add document reference [post.id] to firebase cloud storage
///
///
Future<void> _updatePostPhotoToFirebaseFireStore(PostModel post) async {
  await FirebaseFirestore.instance.collection('posts').doc(post.id).update({
    'id': post.id,
  }).onError((error, stackTrace) => throw error);
}

///Delete post and image to firebase cloud storage and Storage
///
///
Future<void> deletePost(String postId, List<dynamic> photoURLs) async {
  await _removePostToFirebaseFireStore(postId);
  await _removeImageFromFirebaseStorage(photoURLs);
}

///Delete post with [postId] from firebase cloud storage
///
///
Future<void> _removePostToFirebaseFireStore(String postId) async {
  await FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .delete()
      .onError((error, stackTrace) => throw error);
}

///delete list of post photo,[photoURLs], from Storage
///
///
Future<void> _removeImageFromFirebaseStorage(List<dynamic> photoURLs) async {
  for (var photoURL in photoURLs) {
    await FirebaseStorage.instance
        .refFromURL(photoURL)
        .delete()
        .onError((error, stackTrace) => throw error);
  }
}
