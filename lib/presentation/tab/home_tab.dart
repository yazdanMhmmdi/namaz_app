import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/presentation/widget/marjae_small_item.dart';
import 'package:namaz_app/presentation/widget/narratives_item.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 32),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${Strings.homeVideos}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: IColors.black70,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 142,
                decoration: BoxDecoration(
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
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${Strings.homeMaraje}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: IColors.black70,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "${Strings.homeMore}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: IColors.brown,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 128,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    MarjaeSmallItem(delete: false,),
                    MarjaeSmallItem(delete: false,),
                    MarjaeSmallItem(delete: false,),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${Strings.homeNarratives}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: IColors.black70,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "${Strings.homeMore}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: IColors.brown,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  NarrativesItem(deleteSlidable: false,),
                  NarrativesItem(deleteSlidable: false,),
                  NarrativesItem(deleteSlidable: false,),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Center(
                  child: Text(
                    "${Strings.homeMore}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: IColors.brown,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${Strings.homeShohadaBozorgan}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: IColors.black70,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "${Strings.homeMore}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: IColors.brown,
                      ),
                    ),
                  ),
                ],
              ),
              
              Container(
                height: 128,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    MarjaeSmallItem(delete: false,),
                    MarjaeSmallItem(delete: false,),
                    MarjaeSmallItem(delete: false,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
