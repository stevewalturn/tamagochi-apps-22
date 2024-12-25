import 'package:flutter/material.dart';
import 'package:my_app/models/doctor.dart';
import 'package:my_app/shared/app_colors.dart';
import 'package:my_app/shared/text_style.dart';
import 'package:my_app/shared/ui_helpers.dart';

class DoctorListItem extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DoctorListItem({
    Key? key,
    required this.doctor,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      doctor.name,
                      style: heading3Style(context),
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text(
                          'Edit',
                          style: bodyStyle(context),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text(
                          'Delete',
                          style: bodyStyle(context).copyWith(color: Colors.red),
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'edit') {
                        onEdit();
                      } else if (value == 'delete') {
                        onDelete();
                      }
                    },
                  ),
                ],
              ),
              verticalSpaceSmall,
              Text(
                doctor.specialization,
                style: subtitleStyle(context),
              ),
              verticalSpaceTiny,
              Text(
                'License: ${doctor.licenseNumber}',
                style: captionStyle(context),
              ),
              verticalSpaceTiny,
              Text(
                'Phone: ${doctor.phoneNumber}',
                style: captionStyle(context),
              ),
              verticalSpaceTiny,
              Text(
                'Email: ${doctor.email}',
                style: captionStyle(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
