import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/shared/enums/dialog_type.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();
  
  final builders = <dynamic, DialogBuilder>{
    DialogType.infoAlert: (context, request, completer) => AlertDialog(
      title: Text(request.title ?? ''),
      content: Text(request.description ?? ''),
      actions: [
        TextButton(
          child: Text(request.mainButtonTitle ?? 'OK'),
          onPressed: () => completer(DialogResponse(confirmed: true)),
        ),
      ],
    ),
    // Add other dialog builders as needed
  };

  dialogService.registerCustomDialogBuilders(builders);
}