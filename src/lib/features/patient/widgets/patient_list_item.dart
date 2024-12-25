import 'package:flutter/material.dart';
import 'package:my_app/models/patient.dart';
import 'package:my_app/shared/app_colors.dart';
import 'package:my_app/shared/text_style.dart';
import 'package:my_app/shared/ui_helpers.dart';
import 'package:intl/intl.dart';

class PatientListItem extends StatelessWidget {
  final Patient patient;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PatientListItem({
    Key? key,
    required this.patient,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');

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
                      patient.name,
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
              Row(
                children: [
                  Icon(Icons.cake, size: 16, color: kcMediumGrey),
                  horizontalSpaceSmall,
                  Text(
                    'DOB: ${dateFormat.format(patient.dateOfBirth)}',
                    style: subtitleStyle(context),
                  ),
                ],
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  Icon(Icons.person, size: 16, color: kcMediumGrey),
                  horizontalSpaceSmall,
                  Text(
                    'Gender: ${patient.gender}',
                    style: captionStyle(context),
                  ),
                  horizontalSpaceMedium,
                  Icon(Icons.water_drop, size: 16, color: kcMediumGrey),
                  horizontalSpaceSmall,
                  Text(
                    'Blood Type: ${patient.bloodType}',
                    style: captionStyle(context),
                  ),
                ],
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  Icon(Icons.phone, size: 16, color: kcMediumGrey),
                  horizontalSpaceSmall,
                  Text(
                    patient.phoneNumber,
                    style: captionStyle(context),
                  ),
                ],
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: kcMediumGrey),
                  horizontalSpaceSmall,
                  Expanded(
                    child: Text(
                      patient.address,
                      style: captionStyle(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
