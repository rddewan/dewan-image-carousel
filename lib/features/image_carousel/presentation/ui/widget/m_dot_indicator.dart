import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class MDotIndicator extends StatelessWidget {
  final int count;
  final int position;
  final Color dotColor;

  const MDotIndicator({
    required this.count,
    required this.position,
    required this.dotColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: count,
      position: position,
      decorator: DotsDecorator(
        activeColor: dotColor,
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),),
      ),
    );
           
  }
}