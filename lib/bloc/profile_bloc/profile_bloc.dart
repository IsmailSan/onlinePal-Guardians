import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/profile_event.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/profile_state.dart';
import 'package:online_pal_guardians/repositories/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<ProfileInitialized>(_onProfileInitialized);
    on<ProfileSubmitButtonPressed>(_onProfileSubmitButtonPressed);
    on<GetProfile>(_onGetProfile);
  }

  void _onProfileInitialized(ProfileInitialized event, Emitter<ProfileState> emit) {
    emit(ProfileInitial());
  }

  Future<void> _onProfileSubmitButtonPressed(
      ProfileSubmitButtonPressed event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());
    try {
      final response = await profileRepository.updateProfile(
        name: event.name,
        dateOfBirth: event.dateOfBirth,
        gender: event.gender,
        nationality: event.nationality,
        province: event.province,
        city: event.city,
        postalCode: event.postalCode,
        occupation: event.occupation,
        rangeOfFamilyIncome: event.rangeOfFamilyIncome,
        numberOfChildren: event.numberOfChildren,
      );
      emit(UpdateProfileSuccess(profileResponse: response));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }


  Future<void> _onGetProfile(
      GetProfile event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());
    try {
      final response = await profileRepository.getProfile();
      emit(GetProfileSuccess(getProfileResponse: response));
    } catch (e) {
      emit(GetProfileError(message: e.toString()));
    }
  }
}
