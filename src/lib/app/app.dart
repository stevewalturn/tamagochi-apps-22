import 'package:my_app/shared/notice_sheet.dart';
import 'package:my_app/shared/info_alert_dialog.dart';
import 'package:my_app/features/home/home_view.dart';
import 'package:my_app/features/startup/startup_view.dart';
import 'package:my_app/features/doctor/doctor_view.dart';
import 'package:my_app/features/patient/patient_view.dart';
import 'package:my_app/features/medical_record/medical_record_view.dart';
import 'package:my_app/services/doctor_service.dart';
import 'package:my_app/services/patient_service.dart';
import 'package:my_app/services/medical_record_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: DoctorView),
    MaterialRoute(page: PatientView),
    MaterialRoute(page: MedicalRecordView),
  ],
  dependencies: [
    InitializableSingleton(classType: DoctorService),
    InitializableSingleton(classType: PatientService),
    InitializableSingleton(classType: MedicalRecordService),
    InitializableSingleton(classType: BottomSheetService),
    InitializableSingleton(classType: DialogService),
    InitializableSingleton(classType: NavigationService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
  ],
)
class App {}
