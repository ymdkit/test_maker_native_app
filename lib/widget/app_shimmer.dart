import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;
  final bool enabled;

  const AppShimmer({
    super.key,
    this.enabled = true,
    required this.child,
  });

  factory AppShimmer.rect({
    double width = double.infinity,
    required double height,
    ShapeBorder shapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
    ),
  }) =>
      AppShimmer(
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: shapeBorder,
          ),
        ),
      );

  factory AppShimmer.circle({
    required double width,
    required double height,
    ShapeBorder shapeBorder = const CircleBorder(),
  }) =>
      AppShimmer(
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: shapeBorder,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFC7CDD2),
      highlightColor: const Color(0xFFE6E6E6),
      enabled: enabled,
      child: child,
    );
  }
}
