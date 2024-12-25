import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/patient/patient_viewmodel.dart';
import 'package:my_app/features/patient/widgets/patient_form.dart';
import 'package:my_app/features/patient/widgets/patient_list_item.dart';
import 'package:my_app/shared/app_colors.dart';
import 'package:my_app/shared/text_style.dart';
import 'package:my_app/shared/ui_helpers.dart';

class PatientView extends StackedView<PatientViewModel> {
  const PatientView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PatientViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patients',
          style: heading2Style(context).copyWith(color: Colors.white),
        ),
        backgroundColor: kcPrimaryColor,
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(context, viewModel),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPatientForm(context, viewModel),
        child: const Icon(Icons.add),
        backgroundColor: kcPrimaryColor,
      ),
    );
  }

  Widget _buildContent(BuildContext context, PatientViewModel viewModel) {
    if (viewModel.hasError) {
      return Center(
        child: Text(
          viewModel.modelError.toString(),
          style: bodyStyle(context).copyWith(color: Colors.red),
        ),
      );
    }

    if (viewModel.patients.isEmpty) {
      return Center(
        child: Text(
          'No patients found',
          style: bodyStyle(context),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.patients.length,
      separatorBuilder: (context, index) => verticalSpaceMedium,
      itemBuilder: (context, index) {
        final patient = viewModel.patients[index];
        return PatientListItem(
          patient: patient,
          onTap: () => viewModel.selectPatient(patient.id),
          onEdit: () => _showPatientForm(context, viewModel, patient: patient),
          onDelete: () =>
              _showDeleteConfirmation(context, viewModel, patient.id),
        );
      },
    );
  }

  void _showPatientForm(
    BuildContext context,
    PatientViewModel viewModel, {
    patient,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PatientForm(
        patient: patient,
        onSubmit:
            patient == null ? viewModel.createPatient : viewModel.updatePatient,
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    PatientViewModel viewModel,
    String patientId,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Patient'),
        content: const Text(
          'Are you sure you want to delete this patient? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              viewModel.deletePatient(patientId);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  PatientViewModel viewModelBuilder(BuildContext context) => PatientViewModel();

  @override
  void onViewModelReady(PatientViewModel viewModel) => viewModel.initialize();
}
