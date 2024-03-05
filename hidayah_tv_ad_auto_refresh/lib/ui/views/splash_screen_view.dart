import 'package:flutter/material.dart';
import 'package:hidayah_tv_ad/ui/route_navigation.dart';
import 'package:hidayah_tv_ad/ui/views/base_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (model) async {
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        String? isSignedIn = preferences.getString('token');

        Future.delayed(const Duration(seconds: 6), () {
          isSignedIn == null
              ? Navigator.pushNamedAndRemoveUntil(
                  context, RouteNavigation.signIn, (route) => false)
              : Navigator.pushNamedAndRemoveUntil(
                  context, RouteNavigation.home, (route) => false);
        });
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Image.asset('assets/images/launch_image.png'),
          ),
        ),
      ),
    );
  }
}
