import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_size.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../widgets/label_button.dart';
import 'base_skeleton.dart';
import 'skeleton_container.dart';

const double _kMapAspectRatio = 10 / 4;
const double _kImageAspectRatio = 10 / 3.5;
const double _kImageVisibleRatio = 0.5;
const double _kHeaderAspectRatio = 1 / ((1 / _kMapAspectRatio) + (1 / _kImageAspectRatio * _kImageVisibleRatio));
const double _kImageBorderWidth = 6;
const double _kHistoryHeight = 48;

final class AgentDetailScreenSkeleton extends StatelessWidget {
  const AgentDetailScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget image = Container(
      padding: const EdgeInsets.all(_kImageBorderWidth),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.background,
      ),
      child: const CircleAvatar(
        backgroundColor: AppColors.shimmerBase,
      ),
    );

    final Widget header = AspectRatio(
      aspectRatio: _kHeaderAspectRatio,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AspectRatio(
          aspectRatio: _kImageAspectRatio,
          child: image,
        ),
      ),
    );

    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        _AgentDetailScreenSkeleton(key: key),
        header,
      ],
    );
  }
}

final class _AgentDetailScreenSkeleton extends BaseSkeleton {
  const _AgentDetailScreenSkeleton({super.key});

  @override
  Widget buildSkeleton() {
    const Widget header = AspectRatio(
      aspectRatio: _kHeaderAspectRatio,
      child: Align(
        alignment: Alignment.topCenter,
        child: AspectRatio(
          aspectRatio: _kMapAspectRatio,
          child: Material(),
        ),
      ),
    );

    const Widget zone = SkeletonContainer(widthFactor: 0.25);

    const Widget history = SkeletonContainer(height: _kHistoryHeight);

    const Widget signature = SkeletonContainer(widthFactor: 0.40);

    const Widget description = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SkeletonContainer(widthFactor: 0.70),
        SizedBox(height: AppSize.paddingLow),
        SkeletonContainer(widthFactor: 0.60),
        SizedBox(height: AppSize.paddingLow),
        SkeletonContainer(widthFactor: 0.50),
      ],
    );

    const Widget details = Expanded(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: AppSize.paddingLow,
          horizontal: AppSize.padding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            zone,
            SizedBox(height: AppSize.padding),
            history,
            SizedBox(height: AppSize.padding),
            signature,
            SizedBox(height: AppSize.padding),
            description,
          ],
        ),
      ),
    );

    const Widget button = Padding(
      padding: EdgeInsets.all(AppSize.padding),
      child: CustomLabelButton(label: ''),
    );

    return const Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        header,
        details,
        button,
      ],
    );
  }
}
