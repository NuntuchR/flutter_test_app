import 'package:flutter/material.dart';

class PhotoPalette extends StatelessWidget {
  PhotoPalette({@required this.photos});

  final List<Widget> photos;

  @override
  Widget build(BuildContext context) {
    if (photos.isNotEmpty) {
      switch (photos.length) {
        case 1:
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child:  photos[0]
                  ),
                ],
              ),
            ),
          );
          break;
        case 2:
          return Container(
            child: Row(
              children: [
                Expanded(
                  child: photos[0]
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child:  photos[1]
                ),
              ],
            ),
          );
          break;

        case 3:
          return Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: photos[0]
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: photos[1]
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: photos[2]
                    ),
                  ],
                )
              ],
            ),
          );
          break;

        case 4:
          return Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: photos[0]
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child:  photos[1]
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child:  photos[2]
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: photos[3]
                    ),
                  ],
                )
              ],
            ),
          );
          break;

        default:
          return Container();

      }
    } else {
      return Container();
    }
  }
}


