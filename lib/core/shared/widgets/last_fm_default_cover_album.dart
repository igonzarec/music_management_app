// Flutter imports:
import 'package:flutter/material.dart';

import 'package:music_management_app/core/shared/asset_constants.dart'
    as assets;

class LastFmDefaultCoverAlbum extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const LastFmDefaultCoverAlbum(
      {Key? key, required this.name, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 80,
        width: 80,
        child: Stack(
          children: [
            Image.asset(
              assets.albumPlaceholder,
              color: Colors.black.withOpacity(.5),
              colorBlendMode: BlendMode.darken,
            ),
            Container(
              margin: const EdgeInsets.all(5),
              alignment: Alignment.bottomLeft,
              child: Text(
                name,
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
