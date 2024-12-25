import 'package:my_app/features/patient/patient_repository.dart';
import 'package:my_app/models/patient.dart';
import 'package:stacked/stacked_annotations.dart';

class PatientService implements InitializableDependency {
  final PatientRepository _repository;

  PatientService(this._repository);

  @override
  Future<void> init() async {
    // Initialize any required resources
  }

  Future<List<Patient>> getAllPatients() async {
    try {
      return await _repository.getAllPatients();
    } catch (e) {
      throw 'Unable to fetch patients. Please try again later.';
    }
  }

  Future<Patient> getPatientById(String id) async {
    try {
      return await _repository.getPatientById(id);
    } catch (e) {
      throw 'Unable to fetch patient details. Please try again later.';
    }
  }

  Future<void> createPatient(Patient patient) async {
    try {
      await _repository.createPatient(patient);
    } catch (e) {
      throw 'Unable to create patient record. Please try again later.';
    }
  }

  Future<void> updatePatient(Patient patient) async {
    try {
      await _repository.updatePatient(patient);
    } catch (e) {
      throw 'Unable to update patient record. Please try again later.';
    }
  }

  Future<void> deletePatient(String id) async {
    try {
      await _repository.deletePatient(id);
    } catch (e) {
      throw 'Unable to delete patient record. Please try again later.';
    }
  }
}
