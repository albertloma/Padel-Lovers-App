import 'package:flutter/material.dart';

class StatisticItem extends StatelessWidget {
  const StatisticItem({Key key, this.name, this.data, this.isBold = false})
      : super(key: key);

  final String name;
  final String data;
  final bool isBold;

  static const TextStyle defaultStyle = TextStyle(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.normal);
  static const TextStyle boldStyle = TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(name + ': ', style: isBold ? boldStyle : defaultStyle),
        Text(
          data,
          style: isBold ? boldStyle : isBold ? boldStyle : defaultStyle,
        ),
      ],
    );
  }
}
