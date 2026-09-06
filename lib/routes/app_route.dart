import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/routes/router_paths.dart';

import 'app_route.gr.dart';

final appRouterProvider = Provider((ref) => AppRouter());

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          path: Paths.splashScreen,
          page: SplashRoute.page,
        ),
        AutoRoute(
          path: Paths.homeScreen,
          page: HomeRoute.page,
        ),
        AutoRoute(
          path: Paths.productScreen,
          page: ProductDetailRoute.page,
        ),
        AutoRoute(
          path: Paths.arViewScreen,
          page: ARViewRoute.page,
        ),
      ];
}
