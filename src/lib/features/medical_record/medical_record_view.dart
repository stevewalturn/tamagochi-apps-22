import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/medical_record/medical_record_viewmodel.dart';
import 'package:my_app/features/medical_record/widgets/medical_record_form.dart';
import 'package:my_app/features/medical_record/widgets/medical_record_list_item.dart';
import 'package:my_app/shared/app_colors.dart';
import 'package:my_app/shared/text_style.dart';
import 'package:my_app/shared/ui_helpers.dart';

class MedicalRecordView extends StackedView<MedicalRecordViewModel> {
  final String patientId;
  final String doctorId;

  const MedicalRecordView({
    Key? key,
    required this.patientId,
    required this.doctorId,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MedicalRecordViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medical Records',
          style: heading2Style(context).copyWith(color: Colors.white),
        ),
        backgroundColor: kcPrimaryColor,
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(context, viewModel),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMedicalRecordForm(context, viewModel),
        child: const Icon(Icons.add),
        backgroundColor: kcPrimaryColor,
      ),
    );
  }

  Widget _buildContent(BuildContext context, MedicalRecordViewModel viewModel) {
    if (viewModel.hasError) {
      return Center(
        child: Text(
          viewModel.modelError.toString(),
          style: bodyStyle(context).copyWith(color: Colors.red),
        ),
      );
    }

    if (viewModel.records.isEmpty) {
      return Center(
        child: Text(
          'No medical records found',
          style: bodyStyle(context),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.records.length,
      separatorBuilder: (context, index) => verticalSpaceMedium,
      itemBuilder: (context, index) {
        final record = viewModel.records[index];
        return MedicalRecordListItem(
          record: record,
          onTap: () => viewModel.selectRecord(record.id),
          onEdit: () =>
              _showMedicalRecordForm(context, viewModel, record: record),
          onDelete: () =>
              _showDeleteConfirmation(context, viewModel, record.id),
        );
      },
    );
  }

  void _showMedicalRecordForm(
    BuildContext context,
    MedicalRecordViewModel viewModel, {
    record,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MedicalRecordForm(
        record: record,
        patientId: patientId,
        doctorId: doctorId,
        onSubmit:
            record == null ? viewModel.createRecord : viewModel.updateRecord,
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    MedicalRecordViewModel viewModel,
    String recordId,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Medical Record'),
        content: const Text(
          'Are you sure you want to delete this medical record? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              viewModel.deleteRecord(recordId);
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
  MedicalRecordViewModel viewModelBuilder(BuildContext context) =>
      MedicalRecordViewModel();

  @override
  void onViewModelReady(MedicalRecordViewModel viewModel) =>
      viewModel.initialize(patientId);
}
