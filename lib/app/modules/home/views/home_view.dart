import 'package:fit_tracker/app/ui/theme/app_theme.dart';
import 'package:fit_tracker/app/ui/widgets/global_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import 'home_view/home_chart.dart';
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
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Fit Track',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: appThemeData.primaryColor.withAlpha(30),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  // await controller.authController.signOut();
                                  Get.toNamed(Routes.PROFILE_SETTINGS);
                                },
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          stretchModes: [StretchMode.blurBackground],
                          titlePadding: const EdgeInsets.symmetric(
                            horizontal: 27,
                            vertical: 20,
                          ),
                          centerTitle: false,
                          background: const HomeChart(),
                        ),
                        titleSpacing: 27,
                        centerTitle: true,
                        primary: true,
                        snap: false,
                        automaticallyImplyLeading: false,
                        pinned: true,
                        floating: false,
                        expandedHeight: kToolbarHeight +
                            MediaQuery.of(context).padding.top +
                            Get.width,
                        toolbarHeight: kToolbarHeight +
                            MediaQuery.of(context).padding.top +
                            20,
                        backgroundColor: !innerBoxIsScrolled
                            ? Colors.transparent
                            : Colors.white,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        surfaceTintColor: Colors.white,
                      ),
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
