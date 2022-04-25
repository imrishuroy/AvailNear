part of 'dashboard_bloc.dart';

abstract class DashBoardEvent extends Equatable {
  const DashBoardEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentAddress extends DashBoardEvent {
  final String? address;

  const LoadCurrentAddress({required this.address});
}

// class FeedFetchPosts extends FeedEvent {}

// class FeedPaginatePosts extends FeedEvent {}
