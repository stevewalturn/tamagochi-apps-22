import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/doctor/doctor_viewmodel.dart';
import 'package:my_app/features/doctor/widgets/doctor_form.dart';
import 'package:my_app/features/doctor/widgets/doctor_list_item.dart';
import 'package:my_app/shared/app_colors.dart';
import 'package:my_app/shared/text_style.dart';
import 'package:my_app/shared/ui_helpers.dart';

class DoctorView extends StackedView<DoctorViewModel> {
  const DoctorView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DoctorViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctors',
          style: heading2Style(context).copyWith(color: Colors.white),
        ),
        backgroundColor: kcPrimaryColor,
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(context, viewModel),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDoctorForm(context, viewModel),
        child: const Icon(Icons.add),
        backgroundColor: kcPrimaryColor,
      ),
    );
  }

  Widget _buildContent(BuildContext context, DoctorViewModel viewModel) {
    if (viewModel.hasError) {
      return Center(
        child: Text(
          viewModel.modelError.toString(),
          style: bodyStyle(context).copyWith(color: Colors.red),
        ),
      );
    }

    if (viewModel.doctors.isEmpty) {
      return Center(
        child: Text(
          'No doctors found',
          style: bodyStyle(context),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.doctors.length,
      separatorBuilder: (context, index) => verticalSpaceMedium,
      itemBuilder: (context, index) {
        final doctor = viewModel.doctors[index];
        return DoctorListItem(
          doctor: doctor,
          onTap: () => viewModel.selectDoctor(doctor.id),
          onEdit: () => _showDoctorForm(context, viewModel, doctor: doctor),
          onDelete: () =>
              _showDeleteConfirmation(context, viewModel, doctor.id),
        );
      },
    );
  }

  void _showDoctorForm(
    BuildContext context,
    DoctorViewModel viewModel, {
    doctor,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DoctorForm(
        doctor: doctor,
        onSubmit:
            doctor == null ? viewModel.createDoctor : viewModel.updateDoctor,
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    DoctorViewModel viewModel,
    String doctorId,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Doctor'),
        content: const Text(
          'Are you sure you want to delete this doctor? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              viewModel.deleteDoctor(doctorId);
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
  DoctorViewModel viewModelBuilder(BuildContext context) => DoctorViewModel();

  @override
  void onViewModelReady(DoctorViewModel viewModel) => viewModel.initialize();
}
