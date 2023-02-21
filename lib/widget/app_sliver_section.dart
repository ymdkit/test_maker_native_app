import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';

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
            child: AppSectionTitle(title: title),
          ),
        ),
        sliver,
      ],
    );
  }
}
