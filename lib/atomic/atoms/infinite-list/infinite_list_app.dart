import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfiniteListApp<T> extends StatefulWidget {
  final Widget Function(T item, int index) itemBuilder;
  final Widget? loadingBuilder;
  final Widget? errorBuilder;
  final Widget? emptyBuilder;
  final List<T> data;
  final Future<void> Function()? onRefresh;
  final void Function()? onLoadMore;
  final bool isLoading;
  final bool isError;
  final bool isFetching;
  final bool isFetchingNextPage;
  final bool hasNextPage;

  const InfiniteListApp({
    super.key,
    required this.itemBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.emptyBuilder,
    required this.data,
    this.onRefresh,
    this.onLoadMore,
    this.isLoading = false,
    this.isError = false,
    this.isFetching = false,
    this.isFetchingNextPage = false,
    this.hasNextPage = false,
  });

  @override
  InfiniteListAppState<T> createState() => InfiniteListAppState<T>();
}

class InfiniteListAppState<T> extends State<InfiniteListApp<T>> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom || widget.onLoadMore != null) widget.onLoadMore!();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients || !widget.hasNextPage) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  int get lengthList {
    if (widget.data.isEmpty) return 0;
    return widget.data.length;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return widget.loadingBuilder != null
          ? widget.loadingBuilder!
          : const Center(child: CupertinoActivityIndicator());
    }
    return RefreshIndicator(
      onRefresh: () async {
        await widget.onRefresh?.call();
        await Future.delayed(const Duration(milliseconds: 100));
      },
      child: Builder(
        builder: (context) {
          if (widget.isError) {
            return widget.errorBuilder != null
                ? widget.errorBuilder!
                : const Center(child: Text('error'));
          }
          if (widget.data.isEmpty) {
            return widget.emptyBuilder != null
                ? widget.emptyBuilder!
                : const Center(child: Text('no data'));
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return index >= lengthList
                  ? const Center(child: CupertinoActivityIndicator())
                  : widget.itemBuilder(widget.data[index], index);
            },
            itemCount: widget.hasNextPage ? lengthList + 1 : lengthList,
            controller: _scrollController,
          );
        },
      ),
    );
  }
}
