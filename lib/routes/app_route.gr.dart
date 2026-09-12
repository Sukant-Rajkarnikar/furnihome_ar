// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:furnihome_ar/common_models/furniture_model.dart' as _i8;
import 'package:furnihome_ar/feature/ar_view/presentation/screens/ar_view_screen.dart'
    as _i1;
import 'package:furnihome_ar/feature/home/presentation/screens/home_screen.dart'
    as _i2;
import 'package:furnihome_ar/feature/landing/splash_screen.dart' as _i5;
import 'package:furnihome_ar/feature/product_detail/presentation/screens/product_detail_screen.dart'
    as _i3;
import 'package:furnihome_ar/feature/search/presentation/screens/search_screen.dart'
    as _i4;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    ARViewRoute.name: (routeData) {
      final args = routeData.argsAs<ARViewRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ARViewScreen(
          key: args.key,
          furnitureModel: args.furnitureModel,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    ProductDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.ProductDetailScreen(
          key: args.key,
          product: args.product,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SearchScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ARViewScreen]
class ARViewRoute extends _i6.PageRouteInfo<ARViewRouteArgs> {
  ARViewRoute({
    _i7.Key? key,
    required _i8.FurnitureModel furnitureModel,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          ARViewRoute.name,
          args: ARViewRouteArgs(
            key: key,
            furnitureModel: furnitureModel,
          ),
          initialChildren: children,
        );

  static const String name = 'ARViewRoute';

  static const _i6.PageInfo<ARViewRouteArgs> page =
      _i6.PageInfo<ARViewRouteArgs>(name);
}

class ARViewRouteArgs {
  const ARViewRouteArgs({
    this.key,
    required this.furnitureModel,
  });

  final _i7.Key? key;

  final _i8.FurnitureModel furnitureModel;

  @override
  String toString() {
    return 'ARViewRouteArgs{key: $key, furnitureModel: $furnitureModel}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ProductDetailScreen]
class ProductDetailRoute extends _i6.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    _i7.Key? key,
    required _i8.FurnitureModel product,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          ProductDetailRoute.name,
          args: ProductDetailRouteArgs(
            key: key,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailRoute';

  static const _i6.PageInfo<ProductDetailRouteArgs> page =
      _i6.PageInfo<ProductDetailRouteArgs>(name);
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({
    this.key,
    required this.product,
  });

  final _i7.Key? key;

  final _i8.FurnitureModel product;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i4.SearchScreen]
class SearchRoute extends _i6.PageRouteInfo<void> {
  const SearchRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SplashScreen]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
