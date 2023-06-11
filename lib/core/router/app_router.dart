import 'package:flutter/material.dart';
import 'package:muslim/core/router/router_path.dart';

import '../../feautures/quran/view/quran_page.dart';
import '../../feautures/quran/view/widgets/surah_details.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.root:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const QuranKareemPage());
      case RoutePaths.surahDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const DetailPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body:  Center(child: Text("route path not valid "))),
        );
    }
  }
}