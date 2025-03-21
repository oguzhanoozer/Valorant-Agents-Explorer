import 'package:agents_explorer/core/configs/theme/app_colors.dart';
import 'package:agents_explorer/core/configs/theme/app_text_styles.dart' show AppTextStyles;
import 'package:agents_explorer/core/models/agents/api/agent_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/scaffold.dart';
import '../../base_screen_view.dart';
import '../../skeletons/agent_detail_screen_skeleton.dart';
import '../../skeletons/skeleton_builder.dart';
import 'agent_detail_screen_args.dart';
import 'agent_detail_screen_controller.dart';

@RoutePage<void>()
final class AgentDetailScreenView extends BaseScreenView<AgentDetailScreenController, AgentDetailScreenArgs> {
  AgentDetailScreenView({
    Key? key,
    required super.args,
  }) : super(key: key ?? UniqueKey());

  @override
  State<AgentDetailScreenView> createState() => _AgentDetailScreenViewState();
}

final class _AgentDetailScreenViewState extends BaseScreenViewState<AgentDetailScreenView, AgentDetailScreenController, AgentDetailScreenArgs> {
  @override
  CustomScaffold builder(BuildContext context, AgentDetailScreenController controller) {
    return CustomScaffold(
      body: ViewModelBuilder<AgentDetailScreenController>.reactive(
          viewModelBuilder: () => controller,
          builder: (context, controller, child) {
            return SkeletonBuilder(
              enabled: controller.isLoading,
              skeleton: const AgentDetailScreenSkeleton(),
              builder: (BuildContext context) {
                final AgentData? agent = controller.agentDetail;

                return agent == null
                    ? SizedBox()
                    : CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            expandedHeight: 300.0,
                            pinned: true,
                            flexibleSpace: FlexibleSpaceBar(
                              title: Text(
                                agent.displayName ?? '',
                                style: AppTextStyles.title.call(color: AppColors.onSurfaceHigh),
                              ),
                              background: Stack(
                                fit: StackFit.expand,
                                alignment: Alignment.bottomRight,
                                children: [
                                  Image.network(
                                    agent.bustPortrait ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.center,
                                        colors: [
                                          Colors.black.withOpacity(0.8),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: IconButton(
                                        onPressed: () {
                                          controller.saveFavorites();
                                        },
                                        icon: Icon(
                                          Icons.favorite_rounded,
                                          size: 50,
                                          color: agent.isFavorite ? Colors.yellow : Colors.grey,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSectionTitle('Description', context),
                                  SizedBox(height: 8),
                                  _buildSectionContent(agent.description ?? '', context),
                                  SizedBox(height: 16),
                                  _buildSectionTitle('Developer', context),
                                  SizedBox(height: 8),
                                  _buildSectionContent(agent.developerName ?? '', context),
                                  SizedBox(height: 16),
                                  _buildSectionTitle('Release Date', context),
                                  SizedBox(height: 8),
                                  _buildSectionContent(agent.releaseDate ?? '', context),
                                  SizedBox(height: 16),
                                  _buildSectionTitle('Role', context),
                                  SizedBox(height: 8),
                                  _buildSectionContent('${agent.role?.displayName ?? ''} - ${agent.role?.description ?? ''}', context),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
              },
            );
          }),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.body3_high.call(color: AppColors.onSurfaceHigh),
    );
  }

  Widget _buildSectionContent(String content, BuildContext context) {
    return Text(
      content,
      style: AppTextStyles.body2_medium.call(color: AppColors.onSurfaceMedium),
    );
  }
}
