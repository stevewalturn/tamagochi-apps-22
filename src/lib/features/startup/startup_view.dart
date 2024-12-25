import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_app/features/startup/startup_viewmodel.dart';
import 'package:my_app/shared/app_colors.dart';
import 'package:my_app/shared/ui_helpers.dart';
import 'package:my_app/shared/text_style.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Let\'s Get This Party Started! 🎉',
              style: heading1Style(context),
            ),
            verticalSpaceLarge,
            const CircularProgressIndicator(
              color: kcPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
