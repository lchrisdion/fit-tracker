import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jiffy/jiffy.dart';

class GlobalDatePicker extends StatelessWidget {
  final DateTime currentTime;
  final Function(DateTime) onPickedDate;
  final String? description;
  const GlobalDatePicker({
    Key? key,
    required this.currentTime,
    required this.onPickedDate,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime.now().subtract(Duration(
            days: 36000,
          )),
          onChanged: onPickedDate,
          onConfirm: onPickedDate,
          currentTime: currentTime,
          locale: LocaleType.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.calendar_month,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 14,
            ),
            if (description != null)
              Text(
                description ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              )
            else
              Text(
                Jiffy(currentTime).format('dd/MMMM/yyyy'),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF222222),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
