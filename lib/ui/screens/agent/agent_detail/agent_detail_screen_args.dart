import '../../base_screen_args.dart';

final class AgentDetailScreenArgs extends BaseScreenArgs {
  final String movieId;
  final bool isFavorite;
  final void Function()? onUpdateList;

  const AgentDetailScreenArgs({
    required this.movieId,
    required this.isFavorite,
    this.onUpdateList,
  });
}
