import 'package:amer_school/App/Core/utils/Universal_String.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String _profileImageLink;
  const ProfileImage(this._profileImageLink, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: PROFILE_TAG,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: Center(
            child: CircleAvatar(
              radius: 46,
              backgroundColor: Colors.blueGrey,
              backgroundImage: CachedNetworkImageProvider(_profileImageLink),
            ),
          ),
        ),
      ),
    );
  }
}
