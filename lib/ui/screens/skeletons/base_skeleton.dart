import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/theme/app_colors.dart';

const int _kLoop = 0;
const int _kPeriodMilliseconds = 1500;
const double _kDividerHeight = 16;

abstract base class BaseSkeleton extends StatefulWidget {
  const BaseSkeleton({
    super.key,
    this.shouldIterate = false,
  });

  final bool shouldIterate;
  Widget buildSkeleton();

  @override
  State<BaseSkeleton> createState() => _BaseSkeletonState();
}

final class _BaseSkeletonState extends State<BaseSkeleton> {
  final GlobalKey skeletonKey = GlobalKey();
  double? skeletonHeight;

  @override
  void initState() {
    super.initState();
    if (widget.shouldIterate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          final RenderBox? renderBox = skeletonKey.currentContext?.findRenderObject() as RenderBox?;
          skeletonHeight = renderBox?.size.height;
        });
      });
    }
  }

  int getIterableItemCount(BoxConstraints constraints) {
    final int count = switch (skeletonHeight) {
      final double skeletonHeight && > 0 => constraints.maxHeight ~/ skeletonHeight,
      _ => 0,
    };
    return count + 1;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Widget skeleton = widget.buildSkeleton();

        final Widget shimmer = switch (widget.shouldIterate) {
          false => skeleton,
          true => ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: getIterableItemCount(constraints),
              itemBuilder: (BuildContext context, int index) {
                return switch (index) {
                  0 => SizedBox(key: skeletonKey, child: skeleton),
                  _ => skeleton,
                };
              },
              separatorBuilder: (_, __) {
                return const Divider(thickness: AppSize.dividerThickness, height: _kDividerHeight);
              },
            ),
        };

        return Shimmer.fromColors(
          enabled: true,
          baseColor: AppColors.shimmerBase,
          highlightColor: AppColors.shimmerHighlight,
          direction: ShimmerDirection.ltr,
          loop: _kLoop,
          period: const Duration(milliseconds: _kPeriodMilliseconds),
          child: shimmer,
        );
      },
    );
  }
}
