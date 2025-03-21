import 'package:agents_explorer/core/models/agents/api/agent_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/configs/constants/app_icons.dart';
import '../../../../../core/configs/constants/app_size.dart';
import '../../../../../core/configs/theme/app_colors.dart';
import '../../../../../core/configs/theme/app_text_styles.dart';
import 'gesture_detector.dart';

const int _kZoneMaxLine = 3;

final class AgentListTile extends StatelessWidget {
  const AgentListTile({
    super.key,
    required this.agent,
    required this.onTap,
    required this.onToggleTap,
  });

  final AgentData agent;
  final void Function()? onTap;
  final void Function()? onToggleTap;

  @override
  Widget build(BuildContext context) {
    final Widget avatar = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: AppSize.avatarSize,
          backgroundColor: AppColors.surface,
          child: switch (agent.displayIcon) {
            final String url => Image(
                image: NetworkImage(url),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, color: AppColors.onSurfaceLow);
                },
              ),
            null => const Icon(Icons.person, color: AppColors.onSurfaceLow),
          },
        ),
      ],
    );

    final Widget description = Text(
      agent.displayName ?? '',
      style: AppTextStyles.body3_high(),
    );

    final Widget developerName = Text(
      agent.developerName ?? '',
      style: AppTextStyles.body3_high(),
    );

    final Widget displayName = Text(
      agent.displayName ?? '',
      style: AppTextStyles.body2_low(),
      maxLines: _kZoneMaxLine,
      textAlign: TextAlign.end,
      overflow: TextOverflow.ellipsis,
    );

    return CustomGestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSize.paddingLow),
        child: Row(
          children: <Widget>[
            avatar,
            const SizedBox(width: AppSize.padding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  displayName,
                  developerName,
                  description,
                ],
              ),
            ),
            IconButton(
                onPressed: onToggleTap,
                icon: Icon(
                  Icons.favorite,
                  color: agent.isFavorite ? AppColors.navigationBarItemSelected : AppColors.cancelButtonEnd,
                )),
            const SizedBox(width: AppSize.paddingLow),
          ],
        ),
      ),
    );
  }
}
