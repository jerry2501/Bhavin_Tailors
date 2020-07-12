import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class zoomView extends StatelessWidget {
  String imgUrl;
  zoomView({@required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: PhotoView(
       imageProvider: CachedNetworkImageProvider(imgUrl,
       ),
     ),
    );
  }
}
