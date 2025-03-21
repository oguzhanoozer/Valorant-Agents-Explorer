import 'package:agents_explorer/core/models/agents/api/agent_model.dart';
import 'package:agents_explorer/core/utils/app_functions.dart';
import 'package:flutter/material.dart';

import '../../core/configs/constants/app_icons.dart';
import '../../core/configs/constants/app_size.dart';
import '../../core/configs/theme/app_colors.dart';
import '../../core/configs/theme/app_text_styles.dart';
import '../../core/exceptions/base_exception.dart';
import '../../core/models/rx.dart';
import '../../core/utils/dialog_utils.dart';
import 'custom_widgets/create_adaptive_widgets.dart';

const double _kLoadMoreIndicatorSize = 20;
const double _kEmptyBoxSize = 100;
const double _kDividerThickness = 0.1;
const double _kDividerHeight = 2;
const double _kLoadMoreIndicatorStroke = 3;

class LazyListView<T> extends StatefulWidget {
  const LazyListView({
    super.key,
    this.dataHolder,
    this.fetchNotifier,
    this.updateAgentNotifier,
    required this.skeleton,
    required this.emptyString,
    required this.pageSize,
    required this.onFetch,
    required this.itemBuilder,
  });

  final List<T>? dataHolder;
  final Rx<void>? fetchNotifier;
  final Rxn<AgentData>? updateAgentNotifier;

  final Widget skeleton;
  final String emptyString;
  final int pageSize;
  final Future<List<T>> Function(int page) onFetch;
  final Widget Function(BuildContext context, T data) itemBuilder;

  @override
  State<LazyListView<T>> createState() => _LazyListViewState<T>();
}

class _LazyListViewState<T> extends State<LazyListView<T>> {
  late List<T> data;
  bool isFetching = false;
  bool hasMore = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    data = widget.dataHolder ?? <T>[];
    widget.fetchNotifier?.addListener(() => Future<void>.microtask(() => fetch()));
    widget.updateAgentNotifier?.addListener(() {
      final updateAgent = widget.updateAgentNotifier?.value;
      if (updateAgent?.uuid != null) {
        final int index = data.indexWhere((agentValue) => (agentValue as AgentData).uuid == updateAgent?.uuid);
        if (index != -1) {
          (data as List<AgentData>)[index] = (data as List<AgentData>)[index].copyWith(isFavorite: updateAgent?.isFavorite, favoriteModel: updateAgent?.favoriteModel);
          _setState(() {});
        }
      }
    });
    fetch();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent * 0.9) {
        if (hasMore) {
          loadMore();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetch([int page = 0]) async {
    try {
      if (isFetching) {
        return;
      }

      isFetching = true;

      if (page == 0) {
        _setState(() {
          data.clear();
        });
      }

      final List<T> result = await widget.onFetch.call(page);
      if (page == 0 && result.isEmpty) {
        if (context.mounted) {
          await DialogUtils.showFilterNotFoundDialog(context);
        }
      }

      _setState(() {
        final newData = List<T>.from(data);
        data.addAll(result);
        //data = newData;
        hasMore = result.length == widget.pageSize;
        isFetching = false;
      });
    } catch (e) {
      if (context.mounted) {
        await DialogUtils.showErrorDialog(context, message: BaseException.from(e).message);
      }
      _setState(() {
        hasMore = false;
        isFetching = false;
      });
    }
  }

  Future<void> loadMore() async {
    if (hasMore && !isFetching) {
      await fetch(data.length ~/ widget.pageSize);
    }
  }

  void _setState(void Function() callBack) {
    if (mounted) {
      setState(callBack);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => fetch(),
      child: switch (data.length) {
        > 0 => ListView.separated(
            controller: _scrollController,
            itemCount: data.length + (hasMore ? 1 : 0),
            itemBuilder: (BuildContext context, int index) {
              if (index < data.length) {
                return widget.itemBuilder(context, data[index]);
              }
              return Builder(
                builder: (_) {
                  final Widget loadMoreIndicator = Container(
                    width: _kLoadMoreIndicatorSize,
                    height: _kLoadMoreIndicatorSize,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(AppSize.padding),
                    child: const AspectRatio(
                      aspectRatio: 1,
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                        strokeWidth: _kLoadMoreIndicatorStroke,
                      ),
                    ),
                  );

                  return loadMoreIndicator;
                },
              );
            },
            separatorBuilder: (_, __) => const Divider(height: _kDividerHeight, thickness: _kDividerThickness),
          ),
        _ => switch (isFetching) {
            true => widget.skeleton,
            false => _buildEmptyIndicator(),
          }
      },
    );
  }

  Widget _buildEmptyIndicator() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(AppSize.padding),
            constraints: BoxConstraints(minHeight: constraints.minHeight),
            child: Column(
              children: <Widget>[
                AppIcons.logo(
                  size: _kEmptyBoxSize,
                  color: AppColors.onSurfaceLow,
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSize.padding),
                  child: Text(
                    widget.emptyString,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title(
                      color: AppColors.onSurfaceLow,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
