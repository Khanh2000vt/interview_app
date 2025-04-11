import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/bloc/infinite_list/infinite_list_bloc.dart';

class InfiniteListApp<T> extends StatefulWidget {
  final Widget Function(dynamic item, int index) itemBuilder;
  final Widget Function()? loadingBuilder;
  final Widget Function(String message)? errorBuilder;
  final InfiniteListBloc bloc;

  const InfiniteListApp({
    super.key,
    required this.itemBuilder,
    required this.bloc,
    this.loadingBuilder,
    this.errorBuilder,
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
    widget.bloc.add(InfiniteListFetched());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) widget.bloc.add(InfiniteListFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.bloc.add(InfiniteListFetched());
        await Future.delayed(const Duration(milliseconds: 100));
      },
      child: BlocBuilder<InfiniteListBloc, InfiniteListState>(
        bloc: widget.bloc,
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.failure:
              return const Center(child: Text('failed to fetch posts'));
            case PostStatus.success:
              if (state.list.isEmpty) {
                return const Center(child: Text('no posts'));
              }
              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final items = state.list;
                  return index >= state.list.length
                      ? const Center(child: CupertinoActivityIndicator())
                      : widget.itemBuilder(items[index], index);
                },
                itemCount:
                    state.hasReachedMax
                        ? state.list.length
                        : state.list.length + 1,
                controller: _scrollController,
              );
            case PostStatus.initial:
              return const Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }
}
