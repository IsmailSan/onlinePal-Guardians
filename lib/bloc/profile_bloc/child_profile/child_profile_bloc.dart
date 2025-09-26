import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/repositories/profile_repository.dart';
import 'child_profile_event.dart';
import 'child_profile_state.dart';

class ChildProfileBloc extends Bloc<ChildProfileEvent, ChildProfileState> {
  final ProfileRepository profileRepository;

  ChildProfileBloc({required this.profileRepository})
      : super(ChildProfileInitial()) {
    on<GetChildProfile>(_onGetChildProfile);
    on<CreateChildProfile>(_onCreateChildProfile);
    on<UpdateChildProfile>(_onUpdateChildProfile);
    on<GetChildrenProfile>(_onGetChildrenProfile);
    on<AddChildPreference>(_onAddChildPreference);
    on<UpdateChildAvatar>(_onUpdateChildAvatar);
    on<GetChildAvatarList>(_onChildAvatarList);
  }

  Future<void> _onGetChildProfile(
    GetChildProfile event,
    Emitter<ChildProfileState> emit,
  ) async {
    emit(ChildProfileLoading());
    try {
      final response = await profileRepository.getChildProfile(id: event.id);
      emit(GetChildProfileSuccess(response: response));
    } catch (e) {
      emit(GetChildProfileError(message: e.toString()));
    }
  }

  Future<void> _onCreateChildProfile(
    CreateChildProfile event,
    Emitter<ChildProfileState> emit,
  ) async {
    emit(ChildProfileLoading());
    try {
      final response = await profileRepository.createChildProfile(
        username: event.username,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
        name: event.name,
        dateOfBirth: event.dateOfBirth,
        gender: event.gender,
        liveWithParents: event.liveWithParents,
        grade: event.grade,
        school: event.school,
      );
      emit(CreateChildProfileSuccess(response: response));
    } catch (e) {
      emit(ChildProfileError(message: e.toString()));
    }
  }

  Future<void> _onUpdateChildProfile(
    UpdateChildProfile event,
    Emitter<ChildProfileState> emit,
  ) async {
    emit(ChildProfileLoading());
    try {
      final response = await profileRepository.updateChildProfile(
          name: event.name,
          dateOfBirth: event.dateOfBirth,
          gender: event.gender,
          liveWithParents: event.liveWithParents,
          grade: event.grade,
          school: event.school,
          id: event.id);
      emit(UpdateChildProfileSuccess(response: response));
    } catch (e) {
      emit(ChildProfileError(message: e.toString()));
    }
  }

  Future<void> _onGetChildrenProfile(
    GetChildrenProfile event,
    Emitter<ChildProfileState> emit,
  ) async {
    emit(ChildProfileLoading());
    try {
      final response = await profileRepository.getChildrenProfile();
      emit(GetChildrenProfileSuccess(response: response));
    } catch (e) {
      emit(GetChildrenProfileError(message: e.toString()));
    }
  }

  Future<void> _onAddChildPreference(
    AddChildPreference event,
    Emitter<ChildProfileState> emit,
  ) async {
    emit(ChildProfileLoading());
    try {
      final response = await profileRepository.addChildPreference(
        id: event.id,
        favoritePhysicalActivities: event.favoritePhysicalActivities,
        hobbies: event.hobbies,
        favoriteFamilyActivities: event.favoriteFamilyActivities,
        favoriteOnlineActivities: event.favoriteOnlineActivities,
      );
      emit(AddChildPreferenceSuccess(response: response));
    } catch (e) {
      emit(AddChildrenProfileError(message: e.toString()));
    }
  }

  Future<void> _onChildAvatarList(
    GetChildAvatarList event,
    Emitter<ChildProfileState> emit,
  ) async {
    emit(ChildProfileLoading());
    print("➡️ GetChildAvatarList dipanggil dengan gender: ${event.gender}");
    try {
      final response = await profileRepository.getChildAvatarList(
        gender: event.gender,
      );
      print("✅ API response (raw): ${response.toJson()}");
      emit(ChildAvatarListSuccess(response: response));
    } catch (e) {
      print("❌ Error ambil avatar: $e");
      emit(ChildAvatarError(message: e.toString()));
    }
  }

  Future<void> _onUpdateChildAvatar(
    UpdateChildAvatar event,
    Emitter<ChildProfileState> emit,
  ) async {
    emit(ChildProfileLoading());
    try {
      final response = await profileRepository.updateChildAvatar(
          childProfileId: event.childProfileId, avatarId: event.avatarId);
      emit(ChildAvatarUpdateSuccess(response: response));
    } catch (e) {
      emit(ChildAvatarError(message: e.toString()));
    }
  }
}
