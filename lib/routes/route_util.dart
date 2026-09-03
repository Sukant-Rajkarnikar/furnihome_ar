import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

extension ContextExtensions on BuildContext {
  void routeTo(String path) {
    final router = AutoRouter.of(this);
    router.pushNamed(path);
  }

  void pop() {
    final router = AutoRouter.of(this);
    router.maybePop();
  }

  void replaceRouteTo(String path) {
    try {
      final router = AutoRouter.of(this);
      router.replaceNamed(path);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  replaceComponent(comp) {
    try {
      final router = AutoRouter.of(this);
      router.replace(comp);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  routePush(PageRouteInfo comp) {
    final router = AutoRouter.of(this);
    router.push(comp);
  }

  routePushAwait(comp) async {
    final router = AutoRouter.of(this);
    return await router.push(comp);
  }

  currentRoute() {
    final router = AutoRouter.of(this);
    return router.current.name;
  }

  replaceAll(comp) {
    try {
      final router = AutoRouter.of(this);
      router.replaceAll([comp]);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  replaceCompAll(List<PageRouteInfo<dynamic>> comp) {
    final router = AutoRouter.of(this);
    router.replaceAll(comp);
  }

  replaceComp(PageRouteInfo comp) {
    replaceRoute(comp);
  }

  popUntilPath(path) {
    final router = AutoRouter.of(this);
    router.popUntilRouteWithPath(path);
  }

  checkPermission(paths) {
    log("${router.current} 80080000");
    // return paths.contains(context.router.current);
  }

  checkRouteExist(context, {required String autoRouteName}) {
    final previousRoutes =
    AutoRouter.of(context).stack.map((e) => e.name).toList();
    return previousRoutes.contains(autoRouteName);
    // return paths.contains(context.router.current);
  }
}