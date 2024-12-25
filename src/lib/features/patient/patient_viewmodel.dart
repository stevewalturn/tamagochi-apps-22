import 'package:stacked/stacked.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/patient.dart';
import 'package:my_app/services/patient_service.dart';

class PatientViewModel extends BaseViewModel {
  final _patientService = locator<PatientService>();
  List<Patient> _patients = [];
  Patient? _selectedPatient;

  List<Patient> get patients => _patients;
  Patient? get selectedPatient => _selectedPatient;

  Future<void> initialize() async {
    await loadPatients();
  }

  Future<void> loadPatients() async {
    try {
      setBusy(true);
      _patients = await _patientService.getAllPatients();
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> selectPatient(String id) async {
    try {
      setBusy(true);
      _selectedPatient = await _patientService.getPatientById(id);
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> createPatient(Patient patient) async {
    try {
      setBusy(true);
      await _patientService.createPatient(patient);
      await loadPatients();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> updatePatient(Patient patient) async {
    try {
      setBusy(true);
      await _patientService.updatePatient(patient);
      await loadPatients();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> deletePatient(String id) async {
    try {
      setBusy(true);
      await _patientService.deletePatient(id);
      await loadPatients();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }
}
