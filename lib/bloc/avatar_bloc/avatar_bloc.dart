import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/repositories/avatar_repository.dart';
import 'avatar_event.dart';
import 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  final AvatarRepository avatarRepository;

  AvatarBloc({required this.avatarRepository}) : super(AvatarInitial()) {
    on<UpdateAvatar>(_onUpdateAvatar);
    on<GetAvatarList>(_onAvatarList);
  }

  Future<void> _onUpdateAvatar(
      UpdateAvatar event,
      Emitter<AvatarState> emit,
      ) async {
    emit(AvatarLoading());
    try {
      final response = await avatarRepository.updateAvatar(avatarId: event.avatarId);
      emit(AvatarUpdateSuccess(response: response));
    } catch (e) {
      emit(AvatarError(message: e.toString()));
    }
  }

  Future<void> _onAvatarList(
      GetAvatarList event,
      Emitter<AvatarState> emit,
      ) async {
    emit(AvatarLoading());
    try {
      final response = await avatarRepository.avatarList(gender: event.gender);
      emit(AvatarListSuccess(response: response));
    } catch (e) {
      emit(AvatarError(message: e.toString()));
    }
  }
}
