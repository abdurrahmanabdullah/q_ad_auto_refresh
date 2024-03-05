import 'package:flutter/material.dart';
import 'package:hidayah_tv_ad/ui/views/home_view.dart';
import 'package:hidayah_tv_ad/ui/views/sign_in_veiw.dart';
import 'package:hidayah_tv_ad/ui/views/splash_screen_view.dart';
import 'package:hidayah_tv_ad/ui/widgets/simple_notification_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteNavigation {
  static const String splashScreen = 'splashScreen';
  static const String signIn = 'signIn';
  static const String home = 'home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreenView());
      case signIn:
        return MaterialPageRoute(builder: (context) => const SignInView());
      case home:
        return MaterialPageRoute(builder: (context) => const HomeView());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

class GlobalNavigationService {
  static GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
}

Future<void> globalSignOut(int statusCode, String message) async {
  GlobalNavigationService.globalNavigatorKey.currentState!.pushNamedAndRemoveUntil(RouteNavigation.signIn, (route) => false);

  final SharedPreferences preferences = await SharedPreferences.getInstance();

  simpleNotificationWidget(
    statusCode: statusCode,
    message: message,
  );

  preferences.remove('token');
}
