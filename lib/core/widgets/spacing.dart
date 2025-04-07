import 'package:flutter/material.dart';

class XMargin extends StatelessWidget {
  final double x;

  const XMargin(this.x, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(width:x);
  }
}

class YMargin extends StatelessWidget {
  final double y;

  const YMargin(this.y, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: y);
  }
}
