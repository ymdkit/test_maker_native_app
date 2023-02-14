import 'package:flutter/material.dart';

class AppDraggableScrollableSheet extends StatelessWidget {
  const AppDraggableScrollableSheet(
      {this.borderRadius = 8,
      this.showShadow = false,
      this.expand = false,
      this.snap = false,
      this.initialChildSize,
      this.minChildSize,
      this.maxChildSize,
      this.controller,
      required this.builder,
      super.key});

  final double borderRadius;
  final bool showShadow;
  final bool expand;
  final bool snap;
  final double? initialChildSize;
  final double? minChildSize;
  final double? maxChildSize;
  final DraggableScrollableController? controller;
  final ScrollableWidgetBuilder builder;

  double get _defaultSheetSize {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return (data.size.height - data.viewPadding.top) * 0.95 / data.size.height;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize ?? _defaultSheetSize,
      minChildSize: minChildSize ?? 0.25,
      maxChildSize: maxChildSize ?? _defaultSheetSize,
      expand: expand,
      snap: snap,
      controller: controller,
      builder: (context, scrollController) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
          ),
          child: builder(
            context,
            scrollController,
          ),
        );
      },
    );
  }
}
