import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class zoomView extends StatelessWidget {
  String imgUrl;
  zoomView({@required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: PhotoView(
       imageProvider: NetworkImage(imgUrl),
     ),
    );
  }
}
