import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'infinite_list_event.dart';
part 'infinite_list_state.dart';

const throttleDuration = Duration(milliseconds: 100);

class InfiniteListBloc extends Bloc<InfiniteListEvent, InfiniteListState> {
  final Future<List<dynamic>> Function(int startIndex, int limit) fetchData;

  InfiniteListBloc({required this.fetchData}) : super(InfiniteListState()) {
    on<InfiniteListFetched>(
      _onFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onFetched(
    InfiniteListFetched event,
    Emitter<InfiniteListState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      print('state-prev: ${state.list}');
      final posts = await fetchData(state.list.length, 20);
      print('posts: $posts');

      if (posts.isEmpty) {
        return emit(state.copyWith(hasReachedMax: true));
      }

      emit(
        state.copyWith(
          status: PostStatus.success,
          list: [...state.list, ...posts],
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}
