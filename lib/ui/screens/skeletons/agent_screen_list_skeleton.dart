import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_size.dart';
import 'base_skeleton.dart';
import 'skeleton_container.dart';

final class AgentScreenListSkeleton extends BaseSkeleton {
  const AgentScreenListSkeleton({super.key}) : super(shouldIterate: true);

  @override
  Widget buildSkeleton() {
    const Widget avatar = CircleAvatar(
      radius: AppSize.avatarSize,
    );

    const Widget firstColumn = Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SkeletonContainer(widthFactor: 0.50),
          SizedBox(height: AppSize.paddingLow),
          SkeletonContainer(widthFactor: 0.70),
          SizedBox(height: AppSize.paddingLow),
          SkeletonContainer(widthFactor: 0.60),
          SizedBox(height: AppSize.paddingLow),
          SkeletonContainer(widthFactor: 0.30),
        ],
      ),
    );

    const Widget secondColumn = Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SkeletonContainer(widthFactor: 0.70),
          SizedBox(height: AppSize.paddingLow),
          SkeletonContainer(widthFactor: 0.50),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSize.paddingLow,
        AppSize.paddingLow,
        AppSize.paddingLow,
        AppSize.paddingLow,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          avatar,
          SizedBox(width: AppSize.padding),
          firstColumn,
          secondColumn,
        ],
      ),
    );
  }
}
