import 'package:agents_explorer/core/configs/constants/app_size.dart';
import 'package:agents_explorer/core/configs/theme/app_colors.dart';
import 'package:agents_explorer/core/routing/app_navigation.dart';
import 'package:agents_explorer/ui/widgets/base_list_view.dart';
import 'package:agents_explorer/core/models/agents/api/agent_model.dart';
import 'package:agents_explorer/ui/screens/agent/agent/agent_screen_controller.dart';
import 'package:agents_explorer/ui/screens/base_screen_widget.dart';
import 'package:agents_explorer/ui/screens/skeletons/agent_screen_list_skeleton.dart';
import 'package:agents_explorer/ui/widgets/agent_list_tile.dart';
import 'package:agents_explorer/ui/widgets/app_bar.dart';
import 'package:agents_explorer/ui/widgets/scaffold.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../core/configs/constants/app_strings.dart';

@RoutePage<void>()
final class AgentScreenListView extends StatelessWidget with BaseScreenWidgetMixin<AgentScreenController> {
  const AgentScreenListView({super.key});

  @override
  Widget build(BuildContext context) {
    final AgentScreenController controller = getController(context);

    return CustomScaffold(
      appBar: CustomAppBar(
        title: AppStrings.settings(),
        actions: [
          IconButton(
            onPressed: () {
              AppNavigation.goToSettings(context);
            },
            icon: const Icon(
              Icons.settings,
              color: AppColors.primary,
              size: AppSize.iconHigh,
            ),
          )
        ],
      ),
      body: ViewModelBuilder<AgentScreenController>.reactive(
        viewModelBuilder: () => controller,
        onViewModelReady: (viewModel) => controller.fetch(),
        builder: (context, controller, child) {
          final hasMore = controller.visibleAgents.length < controller.agentList.length;

          return BaseListView<AgentData>(
            data: controller.visibleAgents,
            retryFetch: controller.fetch,
            skeleton: const AgentScreenListSkeleton(),
            emptyString: AppStrings.emptyList(),
            isLoading: controller.isBusy,
            hasMore: hasMore,
            onLoadMore: () {
              final nextPage = controller.visibleAgents.length ~/ controller.pageSize;
              controller.fetch(nextPage);
            },
            pageSize: controller.pageSize,
            itemBuilder: (context, agentItem) {
              return AgentListTile(
                agent: agentItem,
                onTap: () => controller.onTapListItem(agentItem),
                onToggleTap: () => controller.showFavoriteDialog(agentItem),
              );
            },
          );
        },
      ),
    );
  }
}
