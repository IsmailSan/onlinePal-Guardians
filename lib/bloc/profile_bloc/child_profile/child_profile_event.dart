import 'package:equatable/equatable.dart';

abstract class ChildProfileEvent extends Equatable {
  const ChildProfileEvent();

  @override
  List<Object?> get props => [];
}

class GetChildProfile extends ChildProfileEvent {
  final int id;

  const GetChildProfile({
    required this.id,
  });
  @override
  List<Object> get props => [
        id,
      ];
}

class CreateChildProfile extends ChildProfileEvent {
  final String username;
  final String password;
  final String passwordConfirmation;
  final String name;
  final String dateOfBirth;
  final String gender;
  final String liveWithParents;
  final String grade;
  final String school;

  const CreateChildProfile({
    required this.username,
    required this.password,
    required this.passwordConfirmation,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.liveWithParents,
    required this.grade,
    required this.school,
  });

  @override
  List<Object> get props => [
        username,
        password,
        passwordConfirmation,
        name,
        dateOfBirth,
        gender,
        liveWithParents,
        grade,
        school,
      ];
}

class UpdateChildProfile extends ChildProfileEvent {
  final String name;
  final String dateOfBirth;
  final String gender;
  final String liveWithParents;
  final String grade;
  final String school;
  final int id;

  const UpdateChildProfile({
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.liveWithParents,
    required this.grade,
    required this.school,
    required this.id,
  });

  @override
  List<Object> get props => [
        name,
        dateOfBirth,
        gender,
        liveWithParents,
        grade,
        school,
      ];
}

class GetChildrenProfile extends ChildProfileEvent {
  const GetChildrenProfile();
}

class AddChildPreference extends ChildProfileEvent {
  final int id;
  final List<String> favoritePhysicalActivities;
  final List<String> hobbies;
  final List<String> favoriteFamilyActivities;
  final List<String> favoriteOnlineActivities;

  const AddChildPreference({
    required this.id,
    required this.favoritePhysicalActivities,
    required this.hobbies,
    required this.favoriteFamilyActivities,
    required this.favoriteOnlineActivities,
  });

  @override
  List<Object> get props => [
        id,
        favoritePhysicalActivities,
        hobbies,
        favoriteFamilyActivities,
        favoriteOnlineActivities,
      ];
}


class UpdateChildAvatar extends ChildProfileEvent {
  final int childProfileId;
  final int avatarId;

  const UpdateChildAvatar({required this.avatarId, required this.childProfileId});

  @override
  List<Object> get props => [avatarId, childProfileId];
}

class GetChildAvatarList extends ChildProfileEvent {
  final String gender;

  const GetChildAvatarList({required this.gender});

  @override
  List<Object> get props => [];
}
