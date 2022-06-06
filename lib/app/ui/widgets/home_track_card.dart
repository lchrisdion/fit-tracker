import 'package:fit_tracker/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class HomeTrackCard extends StatelessWidget {
  final String date;
  final int weight;
  final Function() onRemove;
  const HomeTrackCard(
      {Key? key,
      required this.date,
      required this.weight,
      required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 27,
        vertical: 5,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          30,
        ),
        child: Dismissible(
          key: Key(date),
          background: Container(
            color: Colors.red[300],
            width: double.infinity,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(
              horizontal: 27,
            ),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) async {
            await onRemove();
          },
          child: Container(
            decoration: BoxDecoration(
              color: appThemeData.primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(
              20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Jiffy(date).format('dd'),
                      style: TextStyle(
                        color: appThemeData.primaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      Jiffy(date).format('MMMM - yyyy'),
                      style: TextStyle(
                        color: appThemeData.primaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: appThemeData.primaryColor,
                      borderRadius: BorderRadius.circular(
                        30,
                      )),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        weight.toString(),
                        style: TextStyle(
                          fontSize: 38,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'kg',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
