import 'package:my_app/features/doctor/doctor_repository.dart';
import 'package:my_app/models/doctor.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

class DoctorService implements InitializableDependency {
  final _repository = locator<DoctorRepository>();

  DoctorService();
  
  @override
  Future<void> init() async {
    // Initialize any required resources
  }

  Future<List<Doctor>> getAllDoctors() async {
    try {
      return await _repository.getAllDoctors();
    } catch (e) {
      throw 'Unable to fetch doctors. Please try again later.';
    }
  }

  Future<Doctor> getDoctorById(String id) async {
    try {
      return await _repository.getDoctorById(id);
    } catch (e) {
      throw 'Unable to fetch doctor details. Please try again later.';
    }
  }

  Future<void> createDoctor(Doctor doctor) async {
    try {
      await _repository.createDoctor(doctor);
    } catch (e) {
      throw 'Unable to create doctor record. Please try again later.';
    }
  }

  Future<void> updateDoctor(Doctor doctor) async {
    try {
      await _repository.updateDoctor(doctor);
    } catch (e) {
      throw 'Unable to update doctor record. Please try again later.';
    }
  }

  Future<void> deleteDoctor(String id) async {
    try {
      await _repository.deleteDoctor(id);
    } catch (e) {
      throw 'Unable to delete doctor record. Please try again later.';
    }
  }
}