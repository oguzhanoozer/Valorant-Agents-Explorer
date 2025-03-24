import 'package:flutter/material.dart';

final class SkeletonBuilder extends StatelessWidget {
  const SkeletonBuilder({
    super.key,
    required this.enabled,
    required this.skeleton,
    required this.builder,
  });

  final bool enabled;
  final Widget skeleton;
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return switch (enabled) {
      true => skeleton,
      false => builder(context),
    };
  }
}
