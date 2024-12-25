import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/features/home/home_view.dart';
import 'package:my_app/features/startup/startup_view.dart';
import 'package:my_app/features/doctor/doctor_view.dart';
import 'package:my_app/features/patient/patient_view.dart';
import 'package:my_app/features/medical_record/medical_record_view.dart';
import 'package:my_app/services/doctor_service.dart';
import 'package:my_app/services/patient_service.dart';
import 'package:my_app/services/medical_record_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: DoctorView),
    MaterialRoute(page: PatientView),
    MaterialRoute(page: MedicalRecordView),
  ],
  dependencies: [
    LazySingleton(classType: DoctorService),
    LazySingleton(classType: PatientService), 
    LazySingleton(classType: MedicalRecordService),
    Singleton(classType: BottomSheetService),
    Singleton(classType: DialogService),
    Singleton(classType: NavigationService),
  ],
)
class App {}