import 'package:flutter/material.dart';

class ThiagoWidget extends StatelessWidget {
  final String title;
  const ThiagoWidget({Key? key, this.title = "ThiagoWidget"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(title));
  }
}