import 'package:agents_explorer/core/configs/constants/app_strings.dart';
import 'package:agents_explorer/core/models/agents/api/agent_model.dart';
import 'package:agents_explorer/ui/screens/agent/agent/agent_screen_controller.dart';
import 'package:agents_explorer/ui/screens/base_screen_widget.dart';
import 'package:agents_explorer/ui/screens/skeletons/agent_screen_list_skeleton.dart';
import 'package:agents_explorer/ui/widgets/agent_list_tile.dart';
import 'package:agents_explorer/ui/widgets/list_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/scaffold.dart';

@RoutePage<void>()
final class FavoritesScreenView extends StatelessWidget with BaseScreenWidgetMixin<AgentScreenController> {
  const FavoritesScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final AgentScreenController controller = getController(context);

    return CustomScaffold(
      body: ViewModelBuilder<AgentScreenController>.reactive(
        viewModelBuilder: () => controller,
        builder: (context, controller, child) {
          return LazyListView<AgentData>(
            dataHolder: controller.favoriteAgentList,
            skeleton: const AgentScreenListSkeleton(),
            emptyString: AppStrings.login(),
            pageSize: controller.pageSize,
            onFetch: controller.loadFavorites,
            fetchNotifier: controller.fetchNotifier,
            itemBuilder: (BuildContext context, AgentData agentItem) {
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
