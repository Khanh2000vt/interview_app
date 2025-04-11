part of 'infinite_list_bloc.dart';

sealed class InfiniteListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class InfiniteListFetched extends InfiniteListEvent {}
