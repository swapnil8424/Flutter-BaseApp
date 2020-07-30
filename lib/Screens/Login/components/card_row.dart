import 'package:flutter/material.dart';

class CardRow extends StatelessWidget {
  final String content;
  final IconData icon;

  CardRow(
    this.content,
    this.icon,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 32,),
          SizedBox(width: 12,),
          Flexible(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}