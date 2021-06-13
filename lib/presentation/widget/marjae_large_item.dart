import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';

class MarjaeLargeItem extends StatelessWidget {
  String largePicture;
  String title;
  String marjae_id;
  MarjaeLargeItem(
      {@required this.largePicture,
      @required this.title,
      @required this.marjae_id});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, top: 14),
      child: Container(
        width: 150,
        height: 170,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(largePicture),
                colorFilter: ColorFilter.mode(
                    IColors.purpleCrimson65, BlendMode.srcOver)),
            borderRadius: BorderRadius.circular(20),
            color: IColors.brown,
            boxShadow: [
              BoxShadow(
                offset: Offset(4, 6),
                blurRadius: 10,
                color: IColors.purpleCrimson25,
              )
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white10,
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              print("Hello");
              Navigator.pushNamed(context, '/ahkam',
                  arguments: <String, String>{
                    'marjae_id': "${marjae_id}",
                  });
            },
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 16, left: 8, right: 8),
                      child: Text(
                        "${title}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: IColors.white85,
                          fontSize: 14,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
