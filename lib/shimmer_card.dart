import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


/// A widget that displays a shimmer effect to represent loading content.

///

/// Args:
/// * width: The width of the card.
/// * height: The height of the card.
/// * fillWidth: Whether to fill the width of the screen.
/// * orientation: The orientation of the card.
/// * baseColor: The base color of the shimmer effect.
/// * highlightColor: The highlight color of the shimmer effect.

///

/// Example:

/// ```dart
/// var shimmerCard = ShimmerCard(
///   width: 200,
///   height: 100,
///   fillWidth: true,
/// );
/// ```
class ShimmerCard extends StatelessWidget {
  const ShimmerCard(
      {super.key,
      required this.width,
      required this.height,
      this.orientation = Axis.vertical,
      this.fillWidth = false,
      this.baseColor = Colors.grey,
      this.highlightColor = Colors.black12});

  ///Card width
  final double width;
  ///Card height
  final double height;
  final bool fillWidth;
  final Axis orientation;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fillWidth ? MediaQuery.of(context).size.width - 20 : width,
      height: height,
      margin: EdgeInsets.symmetric(
          vertical: orientation == Axis.vertical ? 25 : 8,
          horizontal: orientation == Axis.horizontal ? 12 : 8),
      child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            decoration: BoxDecoration(
                color: baseColor, borderRadius: BorderRadius.circular(25)),
          )),
    );
  }
}
