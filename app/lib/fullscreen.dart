import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class FullScreen extends StatelessWidget {
 String imageUrl;
 FullScreen(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
    child: PhotoView(
      imageProvider: NetworkImage(imageUrl),
    )
  );
  }
}