import 'package:fit_tracker/app/ui/widgets/global_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../auth_controller.dart';
import '../controllers/home_controller.dart';
import 'home_view/home_track_list.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Obx(
          () => !authController.isLogin.value ||
                  !authController.userHasData.value
              ? Center(
                  child: const GlobalLoading(),
                )
              : NestedScrollView(
                  headerSliverBuilder: ((context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        stretch: true,
                        automaticallyImplyLeading: false,
                        expandedHeight: Get.height - (Get.height / 1.5),
                        pinned: true,
                        toolbarHeight: kToolbarHeight +
                            MediaQuery.of(context).padding.top +
                            20,
                        backgroundColor: !innerBoxIsScrolled
                            ? Colors.transparent
                            : Colors.white,
                        flexibleSpace: FlexibleSpaceBar(
                          stretchModes: const <StretchMode>[
                            StretchMode.zoomBackground,
                            StretchMode.blurBackground,
                            StretchMode.fadeTitle,
                          ],
                          titlePadding: const EdgeInsets.symmetric(
                            horizontal: 27,
                            vertical: 20,
                          ),
                          centerTitle: false,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fit Track',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: innerBoxIsScrolled
                                      ? null
                                      : FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await controller.authController.signOut();
                                },
                                icon: Icon(
                                  Icons.exit_to_app,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SliverOverlapAbsorber(
                      //   handle:
                      //       NestedScrollView.sliverOverlapAbsorberHandleFor(
                      //           context),
                      // ),
                    ];
                  }),
                  body: const HomeTrackList(),
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Obx(
        () => !authController.isLogin.value || !authController.userHasData.value
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () async {
                  await controller.addUserWeight(
                    canPop: true,
                  );
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
