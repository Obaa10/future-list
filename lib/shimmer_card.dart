import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard(
      {super.key,
      required this.width,
      required this.height,
      this.orientation = Axis.vertical,
      this.fillWidth = false});

  final double width;
  final double height;
  final bool fillWidth;
  final Axis orientation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fillWidth ? MediaQuery.of(context).size.width - 20 : width,
      height: height,
      margin: EdgeInsets.symmetric(
          vertical: orientation == Axis.vertical ? 25 : 8,
          horizontal: orientation == Axis.horizontal ? 12 : 8),
      child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.black12,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(25)),
          )),
    );
  }
}
