import 'dart:async';

import 'package:flutter/material.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';

class AhkamShowScreen extends StatefulWidget {
  Map<String, String> args;
  AhkamShowScreen({this.args});
  @override
  _AhkamShowScreenState createState() => _AhkamShowScreenState();
}

class _AhkamShowScreenState extends State<AhkamShowScreen> {
  Map<String, String> arguments;
  String ahkam_id;

  @override
  void initState() {
    arguments = widget.args;
    _getArguments();
    print(ahkam_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: IColors.purpleCrimson,
        body: Stack(
          children: [
            DraggableScrollableSheet(
                initialChildSize: 0.7,
                minChildSize: 0.7,
                builder: (context, scroll) {
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30, right: 16, left: 16, bottom: 16),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListView(
                            controller: scroll,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        child: Center(
                                          child: Text('21',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: IColors.brown,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                      ),
                                      Image.asset(Assets.largeShamse),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "این یک متن تستی است",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: IColors.black70),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "این یک متن تستی است",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: IColors.black70),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ));
  }

  void _getArguments() {
    ahkam_id = arguments['ahkam_id'];
  }
}
