import 'package:agents_explorer/core/models/agents/api/agent_model.dart';

import '../../base_screen_args.dart';

final class AgentDetailScreenArgs extends BaseScreenArgs {
  final String agentId;
  final bool isFavorite;
  final void Function(AgentData)? onUpdateList;

  const AgentDetailScreenArgs({
    required this.agentId,
    required this.isFavorite,
    this.onUpdateList,
  });
}
