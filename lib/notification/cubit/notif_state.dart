part of 'notif_cubit.dart';

enum NotifStatus { initial, loading, succuss, error }

class NotifState extends Equatable {
  final List<Notification?> notifs;
  final Failure failure;
  final NotifStatus status;

  const NotifState({
    required this.notifs,
    required this.failure,
    required this.status,
  });

  factory NotifState.initail() => const NotifState(
      notifs: [], failure: Failure(), status: NotifStatus.initial);

  @override
  List<Object> get props => [notifs, failure, status];

  NotifState copyWith({
    List<Notification?>? notifs,
    Failure? failure,
    NotifStatus? status,
  }) {
    return NotifState(
      notifs: notifs ?? this.notifs,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  String toString() =>
      'NotifState(notifs: $notifs, failure: $failure, status: $status)';
}
