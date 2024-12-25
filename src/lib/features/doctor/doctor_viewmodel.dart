import 'package:stacked/stacked.dart';
import 'package:my_app/services/doctor_service.dart';
import 'package:my_app/models/doctor.dart';
import 'package:get_it/get_it.dart';

class DoctorViewModel extends BaseViewModel {
  final _doctorService = GetIt.instance<DoctorService>();
  List<Doctor> _doctors = [];
  Doctor? _selectedDoctor;

  List<Doctor> get doctors => _doctors;
  Doctor? get selectedDoctor => _selectedDoctor;

  Future<void> initialize() async {
    await loadDoctors();
  }

  Future<void> loadDoctors() async {
    try {
      setBusy(true);
      _doctors = await _doctorService.getAllDoctors();
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> selectDoctor(String id) async {
    try {
      setBusy(true);
      _selectedDoctor = await _doctorService.getDoctorById(id);
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> createDoctor(Doctor doctor) async {
    try {
      setBusy(true);
      await _doctorService.createDoctor(doctor);
      await loadDoctors();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateDoctor(Doctor doctor) async {
    try {
      setBusy(true);
      await _doctorService.updateDoctor(doctor);
      await loadDoctors();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> deleteDoctor(String id) async {
    try {
      setBusy(true);
      await _doctorService.deleteDoctor(id);
      await loadDoctors();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }
}