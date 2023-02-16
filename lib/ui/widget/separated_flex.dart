import 'package:flutter/material.dart';

abstract class SeparatedFlex extends StatelessWidget {
  const SeparatedFlex(
      {required this.children, this.separatorBuilder, super.key});

  final List<Widget> children;
  final Widget Function(BuildContext)? separatorBuilder;

  @protected
  List<Widget> _createChildrenWithSeparator(BuildContext context) {
    final childrenWithSeparator = <Widget>[];
    final separatorBuilder = this.separatorBuilder;
    for (final child in children) {
      childrenWithSeparator.add(child);
      if (child != children.last && separatorBuilder != null) {
        final separator = separatorBuilder(context);
        childrenWithSeparator.add(separator);
      }
    }
    return childrenWithSeparator;
  }
}

class SeparatedColumn extends SeparatedFlex {
  const SeparatedColumn(
      {required super.children,
      super.separatorBuilder,
      this.mainAxisSize = MainAxisSize.max,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      super.key});

  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final childrenWithSeparator = _createChildrenWithSeparator(context);
    return Column(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      children: childrenWithSeparator,
    );
  }
}

class SeparatedRow extends SeparatedFlex {
  const SeparatedRow(
      {required super.children,
      super.separatorBuilder,
      this.mainAxisSize = MainAxisSize.max,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      super.key});

  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final childrenWithSeparator = _createChildrenWithSeparator(context);
    return Row(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      children: childrenWithSeparator,
    );
  }
}
