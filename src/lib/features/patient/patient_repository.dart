import 'package:my_app/models/patient.dart';

class PatientRepository {
  // In a real app, this would connect to an actual database or API
  final List<Patient> _patients = [];

  Future<List<Patient>> getAllPatients() async {
    try {
      return _patients;
    } catch (e) {
      throw 'Failed to fetch patients from database';
    }
  }

  Future<Patient> getPatientById(String id) async {
    try {
      final patient = _patients.firstWhere(
        (p) => p.id == id,
        orElse: () => throw 'Patient not found',
      );
      return patient;
    } catch (e) {
      throw 'Failed to fetch patient details';
    }
  }

  Future<void> createPatient(Patient patient) async {
    try {
      _patients.add(patient);
    } catch (e) {
      throw 'Failed to create patient record';
    }
  }

  Future<void> updatePatient(Patient patient) async {
    try {
      final index = _patients.indexWhere((p) => p.id == patient.id);
      if (index == -1) throw 'Patient not found';
      _patients[index] = patient;
    } catch (e) {
      throw 'Failed to update patient record';
    }
  }

  Future<void> deletePatient(String id) async {
    try {
      final index = _patients.indexWhere((p) => p.id == id);
      if (index == -1) throw 'Patient not found';
      _patients.removeAt(index);
    } catch (e) {
      throw 'Failed to delete patient record';
    }
  }
}
