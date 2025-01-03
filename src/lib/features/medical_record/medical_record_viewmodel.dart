import 'package:stacked/stacked.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/medical_record.dart';
import 'package:my_app/services/medical_record_service.dart';

class MedicalRecordViewModel extends BaseViewModel {
  final _medicalRecordService = locator<MedicalRecordService>();
  List<MedicalRecord> _records = [];
  MedicalRecord? _selectedRecord;
  String? _currentPatientId;

  List<MedicalRecord> get records => _records;
  MedicalRecord? get selectedRecord => _selectedRecord;

  Future<void> initialize(String patientId) async {
    _currentPatientId = patientId;
    await loadRecords();
  }

  Future<void> loadRecords() async {
    try {
      setBusy(true);
      if (_currentPatientId != null) {
        _records = await _medicalRecordService
            .getMedicalRecordsForPatient(_currentPatientId!);
      } else {
        _records = await _medicalRecordService.getAllMedicalRecords();
      }
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> selectRecord(String id) async {
    try {
      setBusy(true);
      _selectedRecord = await _medicalRecordService.getMedicalRecordById(id);
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> createRecord(MedicalRecord record) async {
    try {
      setBusy(true);
      await _medicalRecordService.createMedicalRecord(record);
      await loadRecords();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateRecord(MedicalRecord record) async {
    try {
      setBusy(true);
      await _medicalRecordService.updateMedicalRecord(record);
      await loadRecords();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> deleteRecord(String id) async {
    try {
      setBusy(true);
      await _medicalRecordService.deleteMedicalRecord(id);
      await loadRecords();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }
}
