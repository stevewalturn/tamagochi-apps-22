import 'package:my_app/models/medical_record.dart';

class MedicalRecordRepository {
  // In a real app, this would connect to an actual database or API
  final List<MedicalRecord> _records = [];

  Future<List<MedicalRecord>> getAllMedicalRecords() async {
    try {
      return _records;
    } catch (e) {
      throw 'Failed to fetch medical records from database';
    }
  }

  Future<List<MedicalRecord>> getMedicalRecordsForPatient(
      String patientId) async {
    try {
      return _records.where((r) => r.patientId == patientId).toList();
    } catch (e) {
      throw 'Failed to fetch patient medical records';
    }
  }

  Future<MedicalRecord> getMedicalRecordById(String id) async {
    try {
      final record = _records.firstWhere(
        (r) => r.id == id,
        orElse: () => throw 'Medical record not found',
      );
      return record;
    } catch (e) {
      throw 'Failed to fetch medical record details';
    }
  }

  Future<void> createMedicalRecord(MedicalRecord record) async {
    try {
      _records.add(record);
    } catch (e) {
      throw 'Failed to create medical record';
    }
  }

  Future<void> updateMedicalRecord(MedicalRecord record) async {
    try {
      final index = _records.indexWhere((r) => r.id == record.id);
      if (index == -1) throw 'Medical record not found';
      _records[index] = record;
    } catch (e) {
      throw 'Failed to update medical record';
    }
  }

  Future<void> deleteMedicalRecord(String id) async {
    try {
      final index = _records.indexWhere((r) => r.id == id);
      if (index == -1) throw 'Medical record not found';
      _records.removeAt(index);
    } catch (e) {
      throw 'Failed to delete medical record';
    }
  }
}
