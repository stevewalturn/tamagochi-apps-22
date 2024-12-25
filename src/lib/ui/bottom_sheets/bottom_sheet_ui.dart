import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = <dynamic, SheetBuilder>{
    // Add bottom sheet builders here  
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}