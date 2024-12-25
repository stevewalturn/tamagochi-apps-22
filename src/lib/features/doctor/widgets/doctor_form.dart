import 'package:flutter/material.dart';
import 'package:my_app/models/doctor.dart';
import 'package:my_app/shared/app_colors.dart';
import 'package:my_app/shared/text_style.dart';
import 'package:my_app/shared/ui_helpers.dart';

class DoctorForm extends StatefulWidget {
  final Doctor? doctor;
  final Function(Doctor) onSubmit;

  const DoctorForm({
    Key? key,
    this.doctor,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<DoctorForm> createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _specializationController;
  late TextEditingController _licenseController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.doctor?.name);
    _specializationController =
        TextEditingController(text: widget.doctor?.specialization);
    _licenseController =
        TextEditingController(text: widget.doctor?.licenseNumber);
    _phoneController = TextEditingController(text: widget.doctor?.phoneNumber);
    _emailController = TextEditingController(text: widget.doctor?.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _specializationController.dispose();
    _licenseController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
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
                widget.doctor == null ? 'Add Doctor' : 'Edit Doctor',
                style: heading2Style(context),
              ),
              verticalSpaceMedium,
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter doctor\'s name';
                  }
                  return null;
                },
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: _specializationController,
                decoration: const InputDecoration(labelText: 'Specialization'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter doctor\'s specialization';
                  }
                  return null;
                },
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: _licenseController,
                decoration: const InputDecoration(labelText: 'License Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter license number';
                  }
                  return null;
                },
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
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
                  widget.doctor == null ? 'Add Doctor' : 'Save Changes',
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
      final doctor = Doctor(
        id: widget.doctor?.id ?? DateTime.now().toString(),
        name: _nameController.text,
        specialization: _specializationController.text,
        licenseNumber: _licenseController.text,
        phoneNumber: _phoneController.text,
        email: _emailController.text,
        dateRegistered: widget.doctor?.dateRegistered ?? DateTime.now(),
      );

      widget.onSubmit(doctor);
      Navigator.pop(context);
    }
  }
}
