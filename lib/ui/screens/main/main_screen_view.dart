import 'package:agents_explorer/ui/screens/agent/agent/agent_screen_controller.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../widgets/scaffold.dart';
import '../base_screen_args.dart';
import '../base_screen_view.dart';
import 'widgets/bottom_navigation_bar.dart';

@RoutePage<void>()
final class MainScreenView extends BaseScreenView<AgentScreenController, DefaultScreenArgs> {
  const MainScreenView({
    super.key,
    super.args = const DefaultScreenArgs(),
  });

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

final class _MainScreenViewState extends BaseScreenViewState<MainScreenView, AgentScreenController, DefaultScreenArgs> {
  @override
  CustomScaffold builder(BuildContext context, AgentScreenController controller) {
    return CustomScaffold(
      body: AutoTabsScaffold(
        animationDuration: Duration.zero,
        routes: controller.pages.map((PageItem pageItem) => pageItem.page).toList(),
        bottomNavigationBuilder: (BuildContext context, TabsRouter tabsRouter) {
          return CustomBottomNavigationBar(
            activeIndex: tabsRouter.activeIndex,
            setActiveIndex: (int index) {
              if (tabsRouter.activeIndex == index) {
                tabsRouter.stackRouterOfIndex(index)?.popUntilRoot();
              } else {
                tabsRouter.setActiveIndex(index);
              }
            },
            items: controller.pages.map((PageItem pageItem) {
              return CustomBottomNavigationBarItem(
                icon: pageItem.icon,
                label: pageItem.label,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
