part of 'dashboard_bloc.dart';

abstract class DashBoardEvent extends Equatable {
  const DashBoardEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentAddress extends DashBoardEvent {}

// class FeedFetchPosts extends FeedEvent {}

// class FeedPaginatePosts extends FeedEvent {}
