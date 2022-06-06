import 'package:fit_tracker/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jiffy/jiffy.dart';

import 'global_date_picker.dart';
import 'global_loading.dart';
import 'global_textfield.dart';

class CurrentWeightDialog extends StatelessWidget {
  final TextEditingController weightTextEditingController;
  final Function(String) onChange;
  final Function() onSubmit;
  final bool canPop;
  final bool isSubmitting;
  final DateTime currentTime;
  final Function(DateTime) onPickedDate;
  const CurrentWeightDialog({
    Key? key,
    required this.weightTextEditingController,
    required this.onChange,
    required this.onSubmit,
    required this.currentTime,
    required this.onPickedDate,
    this.canPop: false,
    this.isSubmitting: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => canPop,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(
              27,
            ),
            padding: const EdgeInsets.all(
              27,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Current Weight',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                GlobalTextField(
                  controller: weightTextEditingController,
                  onChanged: onChange,
                  keyboardType: TextInputType.number,
                  inputAction: TextInputAction.done,
                  prefixIcon: Icons.scale,
                  hintText: 'Please enter your weight',
                ),
                GlobalDatePicker(
                  currentTime: currentTime,
                  onPickedDate: onPickedDate,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSubmit,
                    child: isSubmitting
                        ? const GlobalLoading()
                        : Text(
                            'Add data',
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
}
