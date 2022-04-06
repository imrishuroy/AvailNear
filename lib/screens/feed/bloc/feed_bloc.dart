import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/screens/feed/cubit/post_cubit.dart';
import '/blocs/bloc/auth_bloc.dart';
import '/models/failure.dart';
part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final AuthBloc _authBloc;
  final PostCubit _postCubit;

  FeedBloc({
    required PostCubit postCubit,
    required AuthBloc authBloc,
  })  : _authBloc = authBloc,
        _postCubit = postCubit,
        super(FeedState.initial()) {
    _postCubit.loadOwnerPosts();
    print(_authBloc.state);
    on((event, emit) async {});
  }
}
