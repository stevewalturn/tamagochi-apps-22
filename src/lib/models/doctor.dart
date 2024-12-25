import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String id;
  final String name;
  final String specialization;
  final String licenseNumber;
  final String phoneNumber;
  final String email;
  final DateTime dateRegistered;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.licenseNumber,
    required this.phoneNumber,
    required this.email,
    required this.dateRegistered,
  });

  Doctor copyWith({
    String? id,
    String? name,
    String? specialization,
    String? licenseNumber,
    String? phoneNumber,
    String? email,
    DateTime? dateRegistered,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      specialization: specialization ?? this.specialization,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      dateRegistered: dateRegistered ?? this.dateRegistered,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'licenseNumber': licenseNumber,
      'phoneNumber': phoneNumber,
      'email': email,
      'dateRegistered': dateRegistered.toIso8601String(),
    };
  }

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as String,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
      licenseNumber: json['licenseNumber'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      dateRegistered: DateTime.parse(json['dateRegistered'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        specialization,
        licenseNumber,
        phoneNumber,
        email,
        dateRegistered,
      ];
}
