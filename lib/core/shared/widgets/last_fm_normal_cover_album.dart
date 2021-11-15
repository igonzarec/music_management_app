// Flutter imports:
import 'package:flutter/material.dart';

import 'package:music_management_app/core/shared/asset_constants.dart'
    as assets;

class LastFmNormalCoverAlbum extends StatelessWidget {
  final String image;
  final VoidCallback onTap;

  const LastFmNormalCoverAlbum({Key? key, required this.image, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 80,
        width: 80,
        child: FadeInImage(
          placeholder: const AssetImage(assets.albumPlaceholder),
          image: NetworkImage(image),
        ),
      ),
    );
  }
}
