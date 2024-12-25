import 'package:flutter/material.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/shared/app_colors.dart';
import 'package:my_app/shared/text_style.dart';
import 'package:my_app/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: heading3Style(context).copyWith(color: Colors.white),
        ),
        backgroundColor: kcPrimaryColor,
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getResponsiveHorizontalSpaceMedium(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          '🎮 Welcome! 🎮',
                          style: heading2Style(context),
                          textAlign: TextAlign.center,
                        ),
                        verticalSpaceSmall,
                        Text(
                          'Have fun exploring STEVE capability! 🚀✨',
                          style: bodyStyle(context),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpaceMedium,
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Counter',
                          style: heading3Style(context),
                        ),
                        verticalSpaceSmall,
                        Text(
                          viewModel.counterLabel,
                          style: bodyStyle(context),
                        ),
                        verticalSpaceMedium,
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kcPrimaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: viewModel.incrementCounter,
                          child: Text(
                            'Increment',
                            style: buttonTextStyle(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpaceMedium,
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Actions',
                          style: heading3Style(context),
                          textAlign: TextAlign.center,
                        ),
                        verticalSpaceMedium,
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kcMediumGrey,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: viewModel.showDialog,
                          child: Text(
                            'Show Dialog',
                            style: buttonTextStyle(context),
                          ),
                        ),
                        verticalSpaceSmall,
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kcMediumGrey,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: viewModel.showBottomSheet,
                          child: Text(
                            'Show Bottom Sheet',
                            style: buttonTextStyle(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
