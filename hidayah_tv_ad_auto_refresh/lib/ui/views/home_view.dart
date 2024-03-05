import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hidayah_tv_ad/core/enums/view_state.dart';
import 'package:hidayah_tv_ad/core/view_models/home_view_model.dart';
import 'package:hidayah_tv_ad/ui/route_navigation.dart';
import 'package:hidayah_tv_ad/ui/shared/ui_helpers.dart';
import 'package:hidayah_tv_ad/ui/views/base_view.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (model) async {
        WakelockPlus.enable();

        await model.getADs();
        model.initializeAD();

        /// Checking if the ADs are updated or not
        if (model.aDs!.data != null) {
          model.updateADsTimer = Timer.periodic(
            const Duration(seconds: 10),
            (timer) async {
              if (await model.getIsADsUpdated()) {
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNavigation.home, (route) => false);
                }
              }
            },
          );
        }
      },
      onModelClose: (model) {
        /// Closing all the controller and timers
        model.videoPlayerController?.dispose();
        model.youtubePlayerController?.dispose();
        if (model.reTryGetADsTimer != null) {
          model.reTryGetADsTimer!.cancel();
        }
        if (model.updateADsTimer != null) {
          model.updateADsTimer!.cancel();
        }
        WakelockPlus.disable();
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
              child: model.state == ViewState.idle
                  ? model
                      .buildMediaWidget(model.aDUrlList[model.currentADIndex])
                  : const CircularProgressIndicator(),
            ),
            Positioned(
              right: UIHelper.responsiveMediumPadding(context),
              bottom: UIHelper.responsiveMediumPadding(context),
              child: Opacity(
                opacity: 0.8,
                child: SizedBox(
                  width: UIHelper.deviceWidth(context) * 0.05,
                  height: UIHelper.deviceWidth(context) * 0.05,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 8),
                      viewportFraction: 1,
                    ),
                    items: [
                      'assets/images/qad_logo.png',
                      'assets/images/qad_qr.png',
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.asset(i);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
