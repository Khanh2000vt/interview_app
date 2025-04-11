part of 'infinite_list_bloc.dart';

enum PostStatus { initial, success, failure }

final class InfiniteListState<T> extends Equatable {
  final PostStatus status;
  final List<T> list;
  final bool hasReachedMax;

  const InfiniteListState({
    this.status = PostStatus.initial,
    this.list = const [],
    this.hasReachedMax = false,
  });

  InfiniteListState copyWith({
    PostStatus? status,
    List<T>? list,
    bool? hasReachedMax,
  }) {
    return InfiniteListState(
      status: status ?? this.status,
      list: list ?? this.list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, list: ${list.length} }''';
  }

  @override
  List<Object> get props => [status, list, hasReachedMax];
}
