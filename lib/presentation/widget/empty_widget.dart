import 'package:flutter/material.dart';
import 'package:namaz_app/constants/strings.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -200,
      child: Center(child: Text("${Strings.emptyNote}")),
    );
  }
}
