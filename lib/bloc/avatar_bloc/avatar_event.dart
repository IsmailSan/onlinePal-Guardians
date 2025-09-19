import 'package:equatable/equatable.dart';

abstract class AvatarEvent extends Equatable {
  const AvatarEvent();

  @override
  List<Object> get props => [];
}

class UpdateAvatar extends AvatarEvent {
  final int avatarId;

  const UpdateAvatar({required this.avatarId});

  @override
  List<Object> get props => [avatarId];
}

class GetAvatarList extends AvatarEvent {
  final String gender;

  const GetAvatarList({required this.gender});

  @override
  List<Object> get props => [];
}
