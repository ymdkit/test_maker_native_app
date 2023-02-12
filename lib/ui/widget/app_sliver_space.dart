import 'package:flutter/material.dart';

class AppSliverSpace extends StatelessWidget {
  const AppSliverSpace({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(height: height),
    );
  }
}
