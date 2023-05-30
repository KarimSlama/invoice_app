import 'package:flutter/material.dart';

class DividerSeparator extends StatelessWidget {
  const DividerSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: 200,
      color: const Color(0x77d2d2d2),
    );
  }
}
