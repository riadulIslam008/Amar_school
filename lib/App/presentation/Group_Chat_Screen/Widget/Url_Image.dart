import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UrlImage extends StatelessWidget {
  final String imageUrl;

  const UrlImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          width: 3,
          color: Colors.grey[900],
        ),
        image: DecorationImage(
            fit: BoxFit.cover, image: CachedNetworkImageProvider(imageUrl)),
      ),
    );
  }
}
