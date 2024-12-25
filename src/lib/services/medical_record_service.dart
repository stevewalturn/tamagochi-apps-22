import 'package:my_app/features/medical_record/medical_record_repository.dart';
import 'package:my_app/models/medical_record.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

class MedicalRecordService implements InitializableDependency {
  final _repository = locator<MedicalRecordRepository>();

  MedicalRecordService();

  @override
  Future<void> init() async {
    // Initialize any required resources
  }

  Future<List<MedicalRecord>> getAllMedicalRecords() async {
    try {
      return await _repository.getAllMedicalRecords();
    } catch (e) {
      throw 'Unable to fetch medical records. Please try again later.';
    }
  }

  Future<List<MedicalRecord>> getMedicalRecordsForPatient(String patientId) async {
    try {
      return await _repository.getMedicalRecordsForPatient(patientId);
    } catch (e) {
      throw 'Unable to fetch patient medical records. Please try again later.';
    }
  }

  Future<MedicalRecord> getMedicalRecordById(String id) async {
    try {
      return await _repository.getMedicalRecordById(id);
    } catch (e) {
      throw 'Unable to fetch medical record details. Please try again later.';
    }
  }

  Future<void> createMedicalRecord(MedicalRecord record) async {
    try {
      await _repository.createMedicalRecord(record);
    } catch (e) {
      throw 'Unable to create medical record. Please try again later.';
    }
  }

  Future<void> updateMedicalRecord(MedicalRecord record) async {
    try {
      await _repository.updateMedicalRecord(record);
    } catch (e) {
      throw 'Unable to update medical record. Please try again later.';
    }
  }

  Future<void> deleteMedicalRecord(String id) async {
    try {
      await _repository.deleteMedicalRecord(id);
    } catch (e) {
      throw 'Unable to delete medical record. Please try again later.';
    }
  }
}