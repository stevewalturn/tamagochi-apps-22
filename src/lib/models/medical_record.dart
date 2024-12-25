import 'package:equatable/equatable.dart';

class MedicalRecord extends Equatable {
  final String id;
  final String patientId;
  final String doctorId;
  final DateTime dateTime;
  final String diagnosis;
  final String treatment;
  final String prescription;
  final String notes;
  final List<String> attachments;

  const MedicalRecord({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.dateTime,
    required this.diagnosis,
    required this.treatment,
    required this.prescription,
    required this.notes,
    required this.attachments,
  });

  MedicalRecord copyWith({
    String? id,
    String? patientId,
    String? doctorId,
    DateTime? dateTime,
    String? diagnosis,
    String? treatment,
    String? prescription,
    String? notes,
    List<String>? attachments,
  }) {
    return MedicalRecord(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId,
      dateTime: dateTime ?? this.dateTime,
      diagnosis: diagnosis ?? this.diagnosis,
      treatment: treatment ?? this.treatment,
      prescription: prescription ?? this.prescription,
      notes: notes ?? this.notes,
      attachments: attachments ?? this.attachments,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'dateTime': dateTime.toIso8601String(),
      'diagnosis': diagnosis,
      'treatment': treatment,
      'prescription': prescription,
      'notes': notes,
      'attachments': attachments,
    };
  }

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      diagnosis: json['diagnosis'] as String,
      treatment: json['treatment'] as String,
      prescription: json['prescription'] as String,
      notes: json['notes'] as String,
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        patientId,
        doctorId,
        dateTime,
        diagnosis,
        treatment,
        prescription,
        notes,
        attachments,
      ];
}
