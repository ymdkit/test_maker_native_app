import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:test_maker_native_app/ui/widget/app_sliver_space.dart';

class AppSliverSection extends StatelessWidget {
  const AppSliverSection({
    super.key,
    required this.title,
    required this.sliver,
  });

  final String title;
  final Widget sliver;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text(title),
          ),
        ),
        const AppSliverSpace(height: 8),
        sliver,
      ],
    );
  }
}
