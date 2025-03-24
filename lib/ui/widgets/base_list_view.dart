import 'package:agents_explorer/core/configs/constants/app_size.dart';
import 'package:agents_explorer/core/configs/theme/app_colors.dart';
import 'package:agents_explorer/core/configs/theme/app_text_styles.dart';
import 'package:agents_explorer/ui/widgets/custom_widgets/create_adaptive_widgets.dart';
import 'package:flutter/material.dart';

final class BaseListView<T> extends StatefulWidget {
  final List<T> data;
  final Widget Function(BuildContext context, T data) itemBuilder;
  final Widget skeleton;
  final String emptyString;
  final String? errorMessage;
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
    this.errorMessage,
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
              : widget.errorMessage != null
                  ? _buildErrorIndicator()
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
          ? CreateAdaptiveWidgets().adaptiveActivityIndicator(
              color: AppColors.primary,
            )
          : const SizedBox(),
    );
  }

  Widget _buildEmptyIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.emptyString,
            style: AppTextStyles.body2_high(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.errorMessage ?? '',
            style: AppTextStyles.body2_high(
              color: AppColors.buttonStart,
            ),
          ),
          const SizedBox(height: AppSize.padding),
          IconButton(
            onPressed: () {
              widget.retryFetch?.call();
            },
            icon: const Icon(
              Icons.refresh,
              color: AppColors.primary,
              size: AppSize.iconHigh,
            ),
          )
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
