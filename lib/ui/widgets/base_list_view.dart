import 'package:agents_explorer/core/configs/constants/app_size.dart';
import 'package:agents_explorer/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

const double _kLoadMoreIndicatorStroke = 3;

final class BaseListView<T> extends StatefulWidget {
  final List<T> data;
  final Widget Function(BuildContext context, T data) itemBuilder;
  final Widget skeleton;
  final String emptyString;
  final bool isLoading;
  final bool hasMore;
  final VoidCallback? onLoadMore;
  final int pageSize;
  final Function()? retryFetch;

  const BaseListView({
    required this.data,
    required this.itemBuilder,
    required this.skeleton,
    required this.emptyString,
    required this.isLoading,
    required this.hasMore,
    this.onLoadMore,
    required this.pageSize,
    this.retryFetch,
  });

  @override
  _BaseListViewState<T> createState() => _BaseListViewState<T>();
}

class _BaseListViewState<T> extends State<BaseListView<T>> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent * 0.9) {
        if (widget.hasMore && !widget.isLoading) {
          widget.onLoadMore?.call();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.onLoadMore?.call();
      },
      child: widget.data.isEmpty
          ? widget.isLoading
              ? widget.skeleton
              : _buildEmptyIndicator()
          : ListView.builder(
              controller: _scrollController,
              itemCount: widget.data.length + (widget.hasMore ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index < widget.data.length) {
                  return widget.itemBuilder(context, widget.data[index]);
                }
                return _buildLoadMoreIndicator();
              },
            ),
    );
  }

  Widget _buildLoadMoreIndicator() {
    return Center(
      child: widget.isLoading
          ? const CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: _kLoadMoreIndicatorStroke,
            )
          : const SizedBox(),
    );
  }

  Widget _buildEmptyIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.emptyString),
          const SizedBox(height: AppSize.padding),
          IconButton(
            onPressed: () {
              widget.retryFetch?.call();
            },
            icon: const Icon(
              Icons.refresh_outlined,
              color: AppColors.primary,
              size: AppSize.iconHigh,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
