import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/networking/api_provider.dart';

class VideoItem extends StatelessWidget {
  var state;
  VideoItem({this.state});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, cons) {
      if (cons.maxWidth < 400) {
        return getVideoUI(142);
      } else if (cons.maxWidth < 600) {
        return getVideoUI(202);
      } else if (cons.maxWidth < 900) {
        return getVideoUI(262);
      } else if (cons.maxWidth < 1250) {
        return getVideoUI(312);
      } else {
        return getVideoUI(312);
      }
    });
  }

  Widget getVideoUI(double width) {
    return Container(
      height: width,
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter:
                  ColorFilter.mode(IColors.purpleCrimson65, BlendMode.srcOver),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              image: NetworkImage(
                ApiProvider.IMAGE_PROVIDER + state.homeModel.video.thumbnail,
              )),
          color: IColors.brown,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 6),
              blurRadius: 10,
              color: IColors.purpleCrimson25,
            )
          ]),
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 6,
                        offset: Offset(0, 6),
                        color: IColors.black25)
                  ]),
              child: Icon(
                Icons.play_arrow_rounded,
                color: IColors.purpleCrimson,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
