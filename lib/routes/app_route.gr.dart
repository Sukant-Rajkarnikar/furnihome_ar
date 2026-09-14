// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:furnihome_ar/common_models/furniture_model.dart' as _i10;
import 'package:furnihome_ar/feature/ar_view/presentation/screens/ar_view_screen.dart'
    as _i1;
import 'package:furnihome_ar/feature/categories/presentation/screen/categories_screen.dart'
    as _i2;
import 'package:furnihome_ar/feature/home/presentation/screens/home_screen.dart'
    as _i3;
import 'package:furnihome_ar/feature/landing/splash_screen.dart' as _i7;
import 'package:furnihome_ar/feature/product_detail/presentation/screens/product_detail_screen.dart'
    as _i4;
import 'package:furnihome_ar/feature/rooms/presentation/screens/rooms_screen.dart'
    as _i5;
import 'package:furnihome_ar/feature/search/presentation/screens/search_screen.dart'
    as _i6;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    ARViewRoute.name: (routeData) {
      final args = routeData.argsAs<ARViewRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ARViewScreen(
          key: args.key,
          furnitureModel: args.furnitureModel,
        ),
      );
    },
    CategoriesRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CategoriesScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreen(),
      );
    },
    ProductDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.ProductDetailScreen(
          key: args.key,
          product: args.product,
        ),
      );
    },
    RoomsRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.RoomsScreen(),
      );
    },
    SearchRoute.name: (routeData) {
      final args = routeData.argsAs<SearchRouteArgs>(
          orElse: () => const SearchRouteArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.SearchScreen(
          key: args.key,
          initialRooms: args.initialRooms,
          initialCategories: args.initialCategories,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ARViewScreen]
class ARViewRoute extends _i8.PageRouteInfo<ARViewRouteArgs> {
  ARViewRoute({
    _i9.Key? key,
    required _i10.FurnitureModel furnitureModel,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ARViewRoute.name,
          args: ARViewRouteArgs(
            key: key,
            furnitureModel: furnitureModel,
          ),
          initialChildren: children,
        );

  static const String name = 'ARViewRoute';

  static const _i8.PageInfo<ARViewRouteArgs> page =
      _i8.PageInfo<ARViewRouteArgs>(name);
}

class ARViewRouteArgs {
  const ARViewRouteArgs({
    this.key,
    required this.furnitureModel,
  });

  final _i9.Key? key;

  final _i10.FurnitureModel furnitureModel;

  @override
  String toString() {
    return 'ARViewRouteArgs{key: $key, furnitureModel: $furnitureModel}';
  }
}

/// generated route for
/// [_i2.CategoriesScreen]
class CategoriesRoute extends _i8.PageRouteInfo<void> {
  const CategoriesRoute({List<_i8.PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ProductDetailScreen]
class ProductDetailRoute extends _i8.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    _i9.Key? key,
    required _i10.FurnitureModel product,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ProductDetailRoute.name,
          args: ProductDetailRouteArgs(
            key: key,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailRoute';

  static const _i8.PageInfo<ProductDetailRouteArgs> page =
      _i8.PageInfo<ProductDetailRouteArgs>(name);
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({
    this.key,
    required this.product,
  });

  final _i9.Key? key;

  final _i10.FurnitureModel product;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i5.RoomsScreen]
class RoomsRoute extends _i8.PageRouteInfo<void> {
  const RoomsRoute({List<_i8.PageRouteInfo>? children})
      : super(
          RoomsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RoomsRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SearchScreen]
class SearchRoute extends _i8.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i9.Key? key,
    List<int>? initialRooms,
    List<int>? initialCategories,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          SearchRoute.name,
          args: SearchRouteArgs(
            key: key,
            initialRooms: initialRooms,
            initialCategories: initialCategories,
          ),
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i8.PageInfo<SearchRouteArgs> page =
      _i8.PageInfo<SearchRouteArgs>(name);
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    this.initialRooms,
    this.initialCategories,
  });

  final _i9.Key? key;

  final List<int>? initialRooms;

  final List<int>? initialCategories;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, initialRooms: $initialRooms, initialCategories: $initialCategories}';
  }
}

/// generated route for
/// [_i7.SplashScreen]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}
