import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String text;
  final IconData iconData;
  final IconData trailingIcon;
  final Function function;
  final double textSize;
  final Color color;

  const CardWidget(
      {Key key,
      @required this.text,
      @required this.iconData,
      this.trailingIcon,
      this.function,
      this.textSize = 16,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Icon(iconData),
        title: Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            color: color,
          ),
        ),
        trailing: Icon(trailingIcon, color: Colors.green),
        onTap: function,
      ),
    );
  }
}
