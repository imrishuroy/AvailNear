import 'package:availnear/utils/location_util.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/screens/dashboard/cubit/post_cubit.dart';
import '/blocs/bloc/auth_bloc.dart';
import '/models/failure.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  final AuthBloc _authBloc;
  final PostCubit _postCubit;

  DashBoardBloc({
    required PostCubit postCubit,
    required AuthBloc authBloc,
  })  : _authBloc = authBloc,
        _postCubit = postCubit,
        super(DashBoardState.initial()) {
    _postCubit.loadOwnerPosts();
    print(_authBloc.state);

    on<LoadCurrentAddress>((event, emit) async {
      final currentAddress = await LocationUtil.getCurrentAddress();
      emit(state.copyWith(
          currentAddress: currentAddress, status: DashBoardStatus.succsss));
    });
  }
}
