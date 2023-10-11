/* import 'package:flutter/material.dart';
import 'package:us_ip_tv/features/view/home_view.dart';

import '../view/splash_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String mainRoute = '/home';
  static const String storeDetailRoute = '/storeDetail';
  static const String denemeRoute = '/deneme';
}

class RouteManager {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());

      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const HomeView(data: [],));
      case Routes.storeDetailRoute:
        return MaterialPageRoute(builder: (_) => const NamesView());
      case Routes.denemeRoute:
        return MaterialPageRoute(builder: (_) => const DenemeView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(
                child: Text(AppStrings.oppsss),
              ),
            ));
  }
}
 */