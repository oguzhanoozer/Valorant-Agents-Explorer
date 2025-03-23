import 'package:agents_explorer/core/configs/constants/app_strings.dart';
import 'package:agents_explorer/core/models/agents/api/agent_model.dart';
import 'package:agents_explorer/ui/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/configs/constants/app_size.dart';
import '../../../../../core/configs/theme/app_colors.dart';
import '../../../../../core/configs/theme/app_text_styles.dart';
import 'gesture_detector.dart';

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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: AppSize.avatarSize,
            backgroundColor: AppColors.surface,
            child: CustomNetworkImage(
              imageUrl: agent.displayIcon,
              fit: BoxFit.contain,
              fallbackIcon: Icons.person,
              fallbackIconSize: 80,
              fallbackIconColor: AppColors.onSurfaceLow,
            ),
          ),
        ),
      ],
    );

    final Widget role = Row(
      children: [
        Row(
          children: [
            Text(
              '${AppStrings.role()}:',
              style: AppTextStyles.body3_high(color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.8)),
            ),
            const SizedBox(width: AppSize.paddingLow),
            Text(
              agent.role?.displayName ?? '',
              style: AppTextStyles.body2_high(color: AppColors.primary),
            ),
          ],
        ),
      ],
    );

    final Widget developerName = Row(
      children: [
        Row(
          children: [
            Text(
              '${AppStrings.developer()}:',
              style: AppTextStyles.body3_high(color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.8)),
            ),
            const SizedBox(width: AppSize.paddingLow),
            Text(
              agent.developerName ?? '',
              style: AppTextStyles.body2_high(color: AppColors.primary),
            ),
          ],
        ),
      ],
    );

    final Widget displayName = Row(
      children: [
        Row(
          children: [
            Text(
              '${AppStrings.displayName()}:',
              style: AppTextStyles.body3_high(color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.8)),
            ),
            const SizedBox(width: AppSize.paddingLow),
            Text(
              (agent.displayName ?? '').toUpperCase(),
              style: AppTextStyles.body3_high(color: AppColors.primary),
            ),
          ],
        ),
      ],
    );

    return CustomGestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                  role,
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
