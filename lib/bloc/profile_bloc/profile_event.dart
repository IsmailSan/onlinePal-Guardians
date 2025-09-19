import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileInitialized extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class ProfileSubmitButtonPressed extends ProfileEvent {
  final String name;
  final String dateOfBirth;
  final String gender;
  final String nationality;
  final String province;
  final String city;
  final String postalCode;
  final String occupation;
  final String rangeOfFamilyIncome;
  final int numberOfChildren;

  const ProfileSubmitButtonPressed({
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.nationality,
    required this.province,
    required this.city,
    required this.postalCode,
    required this.occupation,
    required this.rangeOfFamilyIncome,
    required this.numberOfChildren,
  });

  @override
  List<Object> get props => [
    name,
    dateOfBirth,
    gender,
    nationality,
    province,
    city,
    postalCode,
    occupation,
    rangeOfFamilyIncome,
    numberOfChildren,
  ];
}

class GetProfile extends ProfileEvent {
  const GetProfile();

  @override
  List<Object> get props => [];
}