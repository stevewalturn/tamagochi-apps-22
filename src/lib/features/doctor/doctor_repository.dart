import 'package:my_app/models/doctor.dart';

class DoctorRepository {
  // In a real app, this would connect to an actual database or API
  final List<Doctor> _doctors = [];

  Future<List<Doctor>> getAllDoctors() async {
    try {
      return _doctors;
    } catch (e) {
      throw 'Failed to fetch doctors from database';
    }
  }

  Future<Doctor> getDoctorById(String id) async {
    try {
      final doctor = _doctors.firstWhere(
        (d) => d.id == id,
        orElse: () => throw 'Doctor not found',
      );
      return doctor;
    } catch (e) {
      throw 'Failed to fetch doctor details';
    }
  }

  Future<void> createDoctor(Doctor doctor) async {
    try {
      if (_doctors.any((d) => d.licenseNumber == doctor.licenseNumber)) {
        throw 'A doctor with this license number already exists';
      }
      _doctors.add(doctor);
    } catch (e) {
      throw 'Failed to create doctor record';
    }
  }

  Future<void> updateDoctor(Doctor doctor) async {
    try {
      final index = _doctors.indexWhere((d) => d.id == doctor.id);
      if (index == -1) throw 'Doctor not found';
      _doctors[index] = doctor;
    } catch (e) {
      throw 'Failed to update doctor record';
    }
  }

  Future<void> deleteDoctor(String id) async {
    try {
      final index = _doctors.indexWhere((d) => d.id == id);
      if (index == -1) throw 'Doctor not found';
      _doctors.removeAt(index);
    } catch (e) {
      throw 'Failed to delete doctor record';
    }
  }
}
