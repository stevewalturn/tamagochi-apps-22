import 'package:flutter/material.dart';
import 'package:my_app/models/patient.dart';
import 'package:my_app/shared/app_colors.dart';
import 'package:my_app/shared/text_style.dart';
import 'package:my_app/shared/ui_helpers.dart';
import 'package:intl/intl.dart';

class PatientForm extends StatefulWidget {
  final Patient? patient;
  final Function(Patient) onSubmit;

  const PatientForm({
    Key? key,
    this.patient,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<PatientForm> createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _emergencyContactController;
  DateTime? _selectedDate;
  String _selectedGender = 'Male';
  String _selectedBloodType = 'A+';

  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  final List<String> _bloodTypeOptions = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.patient?.name);
    _addressController = TextEditingController(text: widget.patient?.address);
    _phoneController = TextEditingController(text: widget.patient?.phoneNumber);
    _emergencyContactController =
        TextEditingController(text: widget.patient?.emergencyContact);
    _selectedDate = widget.patient?.dateOfBirth;
    _selectedGender = widget.patient?.gender ?? 'Male';
    _selectedBloodType = widget.patient?.bloodType ?? 'A+';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
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
                widget.patient == null ? 'Add Patient' : 'Edit Patient',
                style: heading2Style(context),
              ),
              verticalSpaceMedium,
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter patient\'s name';
                  }
                  return null;
                },
              ),
              verticalSpaceSmall,
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                  ),
                  child: Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : DateFormat('MMM dd, yyyy').format(_selectedDate!),
                    style: bodyStyle(context),
                  ),
                ),
              ),
              verticalSpaceSmall,
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: _genderOptions.map((String gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                  });
                },
              ),
              verticalSpaceSmall,
              DropdownButtonFormField<String>(
                value: _selectedBloodType,
                decoration: const InputDecoration(labelText: 'Blood Type'),
                items: _bloodTypeOptions.map((String type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedBloodType = newValue!;
                  });
                },
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter patient\'s address';
                  }
                  return null;
                },
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: _emergencyContactController,
                decoration:
                    const InputDecoration(labelText: 'Emergency Contact'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter emergency contact number';
                  }
                  return null;
                },
              ),
              verticalSpaceMedium,
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  widget.patient == null ? 'Add Patient' : 'Save Changes',
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
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select date of birth'),
          ),
        );
        return;
      }

      final patient = Patient(
        id: widget.patient?.id ?? DateTime.now().toString(),
        name: _nameController.text,
        dateOfBirth: _selectedDate!,
        gender: _selectedGender,
        bloodType: _selectedBloodType,
        address: _addressController.text,
        phoneNumber: _phoneController.text,
        emergencyContact: _emergencyContactController.text,
        registrationDate: widget.patient?.registrationDate ?? DateTime.now(),
      );

      widget.onSubmit(patient);
      Navigator.pop(context);
    }
  }
}
