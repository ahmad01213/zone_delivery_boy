import 'package:flutter/material.dart';

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget({Key key, @required this.color, @required this.text, @required this.onPressed})
      : super(key: key);

  final Color color;
  final Text text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: this.color.withOpacity(0.4), blurRadius: 1, offset: Offset(0, 1)),
          BoxShadow(color: this.color.withOpacity(0.4), blurRadius: 1, offset: Offset(0, 1))
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: color
      ),
      child: FlatButton(
        onPressed: this.onPressed,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        child: this.text,
      ),
    );
  }
}
