import 'package:flutter/material.dart';
import 'package:my_app/models/medical_record.dart';
import 'package:my_app/shared/app_colors.dart';
import 'package:my_app/shared/text_style.dart';
import 'package:my_app/shared/ui_helpers.dart';
import 'package:intl/intl.dart';

class MedicalRecordListItem extends StatelessWidget {
  final MedicalRecord record;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MedicalRecordListItem({
    Key? key,
    required this.record,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy HH:mm');

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
                      dateFormat.format(record.dateTime),
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
                'Diagnosis: ${record.diagnosis}',
                style: subtitleStyle(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpaceTiny,
              Text(
                'Treatment: ${record.treatment}',
                style: captionStyle(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (record.attachments.isNotEmpty) ...[
                verticalSpaceTiny,
                Row(
                  children: [
                    Icon(
                      Icons.attach_file,
                      size: 16,
                      color: kcMediumGrey,
                    ),
                    horizontalSpaceTiny,
                    Text(
                      '${record.attachments.length} attachment(s)',
                      style: captionStyle(context),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
