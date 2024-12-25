import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final String id;
  final String name;
  final DateTime dateOfBirth;
  final String gender;
  final String bloodType;
  final String address;
  final String phoneNumber;
  final String emergencyContact;
  final DateTime registrationDate;

  const Patient({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.bloodType,
    required this.address,
    required this.phoneNumber,
    required this.emergencyContact,
    required this.registrationDate,
  });

  Patient copyWith({
    String? id,
    String? name,
    DateTime? dateOfBirth,
    String? gender,
    String? bloodType,
    String? address,
    String? phoneNumber,
    String? emergencyContact,
    DateTime? registrationDate,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      bloodType: bloodType ?? this.bloodType,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      registrationDate: registrationDate ?? this.registrationDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'bloodType': bloodType,
      'address': address,
      'phoneNumber': phoneNumber,
      'emergencyContact': emergencyContact,
      'registrationDate': registrationDate.toIso8601String(),
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      name: json['name'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      gender: json['gender'] as String,
      bloodType: json['bloodType'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      emergencyContact: json['emergencyContact'] as String,
      registrationDate: DateTime.parse(json['registrationDate'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        dateOfBirth,
        gender,
        bloodType,
        address,
        phoneNumber,
        emergencyContact,
        registrationDate,
      ];
}
