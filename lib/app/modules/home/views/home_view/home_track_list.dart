import 'package:fit_tracker/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../ui/widgets/home_track_card.dart';

class HomeTrackList extends GetView<HomeController> {
  const HomeTrackList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 40,
      ),
      child: CustomScrollView(
        slivers: [
          // SliverOverlapInjector(
          //   handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          // ),
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var trackItem = controller.listTrack[index];
                  return HomeTrackCard(
                    weight: trackItem.weight ?? 0,
                    date: trackItem.date ?? '',
                    onRemove: () {
                      controller.removeTrackData(
                        index: index,
                        date: trackItem.date ?? "",
                      );
                    },
                  );
                },
                childCount: controller.listTrack.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
