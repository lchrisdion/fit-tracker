import 'package:fit_tracker/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class GlobalLoading extends StatelessWidget {
  final Color? customColor;
  const GlobalLoading({
    Key? key,
    this.customColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: CircularProgressIndicator(
          color: customColor ?? appThemeData.primaryColor,
        ),
        height: 20,
        width: 20,
      ),
    );
  }
}
