import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:octo_image/octo_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LiveTvItem extends StatelessWidget {
  bool delete;
  String title;
  String thumbPicture;
  Function onTap;
  String hash;
  bool isDarkMode = false;
  double fontSize = 0;
  bool isLive = false;
  LiveTvItem({
    @required this.delete,
    @required this.title,
    @required this.thumbPicture,
    @required this.onTap,
    @required this.hash,
    @required this.isDarkMode,
    @required this.fontSize,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 16, top: 8),
      child: Stack(
        children: [
          Container(
            width: 104,
            height: 104,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: OctoImage(
                image: CachedNetworkImageProvider(
                  ApiProvider.IMAGE_PROVIDER + thumbPicture.trim(),
                ),
                placeholderBuilder: OctoPlaceholder.blurHash(
                  hash,
                ),
                errorBuilder: OctoError.icon(color: Colors.red),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 104,
            height: 104,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isDarkMode
                  ? IColors.darkLightPink65
                  : IColors.purpleCrimson65,
            ),
            child: Stack(
              children: [
                delete
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white10,
                    borderRadius: BorderRadius.circular(20),
                    onTap: onTap,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                            ),
                            child: Container(
                              width: 88,
                              child: Text(
                                "${title}",
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 14 + fontSize,
                                  color: IColors.white85,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
