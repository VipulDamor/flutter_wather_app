import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconButtonCustome extends StatelessWidget {
  VoidCallback onpress;
  IconData iconData;

  IconButtonCustome(this.onpress, this.iconData);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpress,
      child: Icon(
        iconData,
        size: 41.0,
        color: Colors.black,
      ),
      style: ButtonStyle(alignment: Alignment.centerLeft),
    );
  }
}
