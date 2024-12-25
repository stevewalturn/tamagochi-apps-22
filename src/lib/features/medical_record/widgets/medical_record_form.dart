import 'package:flutter/material.dart';
import 'package:my_app/models/medical_record.dart';
import 'package:my_app/shared/app_colors.dart';
import 'package:my_app/shared/text_style.dart';
import 'package:my_app/shared/ui_helpers.dart';
import 'package:file_picker/file_picker.dart';

class MedicalRecordForm extends StatefulWidget {
  final MedicalRecord? record;
  final String patientId;
  final String doctorId;
  final Function(MedicalRecord) onSubmit;

  const MedicalRecordForm({
    Key? key,
    this.record,
    required this.patientId,
    required this.doctorId,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<MedicalRecordForm> createState() => _MedicalRecordFormState();
}

class _MedicalRecordFormState extends State<MedicalRecordForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _diagnosisController;
  late TextEditingController _treatmentController;
  late TextEditingController _prescriptionController;
  late TextEditingController _notesController;
  List<String> _attachments = [];

  @override
  void initState() {
    super.initState();
    _diagnosisController =
        TextEditingController(text: widget.record?.diagnosis);
    _treatmentController =
        TextEditingController(text: widget.record?.treatment);
    _prescriptionController =
        TextEditingController(text: widget.record?.prescription);
    _notesController = TextEditingController(text: widget.record?.notes);
    _attachments = widget.record?.attachments ?? [];
  }

  @override
  void dispose() {
    _diagnosisController.dispose();
    _treatmentController.dispose();
    _prescriptionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        setState(() {
          _attachments.addAll(result.files.map((file) => file.path!));
        });
      }
    } catch (e) {
      // Handle file picking errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to pick files. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.record == null
                    ? 'Add Medical Record'
                    : 'Edit Medical Record',
                style: heading2Style(context),
              ),
              verticalSpaceMedium,
              TextFormField(
                controller: _diagnosisController,
                decoration: const InputDecoration(labelText: 'Diagnosis'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter diagnosis';
                  }
                  return null;
                },
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: _treatmentController,
                decoration: const InputDecoration(labelText: 'Treatment'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter treatment';
                  }
                  return null;
                },
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: _prescriptionController,
                decoration: const InputDecoration(labelText: 'Prescription'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter prescription';
                  }
                  return null;
                },
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
                maxLines: 3,
              ),
              verticalSpaceMedium,
              ElevatedButton.icon(
                onPressed: _pickFiles,
                icon: const Icon(Icons.attach_file),
                label: const Text('Add Attachments'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcPrimaryColorDark,
                ),
              ),
              if (_attachments.isNotEmpty) ...[
                verticalSpaceSmall,
                Text(
                  'Attachments (${_attachments.length}):',
                  style: subtitleStyle(context),
                ),
                verticalSpaceTiny,
                ...List.generate(
                  _attachments.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.insert_drive_file),
                        horizontalSpaceSmall,
                        Expanded(
                          child: Text(
                            _attachments[index].split('/').last,
                            style: bodyStyle(context),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              _attachments.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              verticalSpaceMedium,
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  widget.record == null ? 'Add Record' : 'Save Changes',
                  style: buttonTextStyle(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final record = MedicalRecord(
        id: widget.record?.id ?? DateTime.now().toString(),
        patientId: widget.patientId,
        doctorId: widget.doctorId,
        dateTime: widget.record?.dateTime ?? DateTime.now(),
        diagnosis: _diagnosisController.text,
        treatment: _treatmentController.text,
        prescription: _prescriptionController.text,
        notes: _notesController.text,
        attachments: _attachments,
      );

      widget.onSubmit(record);
      Navigator.pop(context);
    }
  }
}
