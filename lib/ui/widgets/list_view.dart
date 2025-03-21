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

class LazyListView<T> extends StatefulWidget {
  const LazyListView({
    super.key,
    this.dataHolder,
    this.fetchNotifier,
    required this.skeleton,
    required this.emptyString,
    required this.pageSize,
    required this.onFetch,
    required this.itemBuilder,
  });

  final List<T>? dataHolder;
  final Rx<void>? fetchNotifier;

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

  @override
  void initState() {
    super.initState();
    data = widget.dataHolder ?? <T>[];
    widget.fetchNotifier?.addListener(() => Future<void>.microtask(() => fetch()));
    fetch();
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
        newData.addAll(result);
        //data = newData;
        data.addAll(newData);
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
      onRefresh: () async {
        fetch();
      },
      child: switch (data.length) {
        > 0 => ListView.separated(
            itemCount: data.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < data.length) {
                return widget.itemBuilder(context, data[index]);
              }
              return _buildLoadMoreIndicator();
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

  Widget _buildLoadMoreIndicator() {
    return Visibility(
      visible: hasMore,
      child: Builder(
        builder: (BuildContext context) {
          loadMore();
          return Container(
            width: _kLoadMoreIndicatorSize,
            height: _kLoadMoreIndicatorSize,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(AppSize.padding),
            child: AspectRatio(
              aspectRatio: 1,
              child: CreateAdaptiveWidgets().adaptiveActivityIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        },
      ),
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
