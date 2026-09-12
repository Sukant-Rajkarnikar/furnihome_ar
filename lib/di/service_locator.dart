import 'package:furnihome_ar/feature/product_detail/data/local/product_detail_local.dart';
import 'package:furnihome_ar/feature/product_detail/data/local/product_detail_local_impl.dart';
import 'package:furnihome_ar/feature/product_detail/data/product_detail_repository.dart';
import 'package:furnihome_ar/feature/product_detail/data/product_detail_repository_impl.dart';
import 'package:furnihome_ar/feature/product_detail/data/remote/product_detail_remote.dart';
import 'package:furnihome_ar/feature/product_detail/data/remote/product_detail_remote_impl.dart';
import 'package:furnihome_ar/shared/network/http_client.dart';
import 'package:get_it/get_it.dart';
import 'package:furnihome_ar/feature/categories/data/categories_repository.dart';
import 'package:furnihome_ar/feature/categories/data/categories_repository_impl.dart';
import 'package:furnihome_ar/feature/categories/data/local/categories_local.dart';
import 'package:furnihome_ar/feature/categories/data/local/categories_local_impl.dart';
import 'package:furnihome_ar/feature/categories/data/remote/categories_remote.dart';
import 'package:furnihome_ar/feature/categories/data/remote/categories_remote_impl.dart';
import 'package:furnihome_ar/feature/categories/screens/categories_viewmodel.dart';
import 'package:furnihome_ar/feature/home/data/home_repository.dart';
import 'package:furnihome_ar/feature/home/data/home_repository_impl.dart';
import 'package:furnihome_ar/feature/home/data/local/home_local.dart';
import 'package:furnihome_ar/feature/home/data/local/home_local_impl.dart';
import 'package:furnihome_ar/feature/home/data/remote/home_remote.dart';
import 'package:furnihome_ar/feature/home/data/remote/home_remote_impl.dart';
import 'package:furnihome_ar/feature/rooms/data/local/rooms_local.dart';
import 'package:furnihome_ar/feature/rooms/data/local/rooms_local_impl.dart';
import 'package:furnihome_ar/feature/rooms/data/remote/rooms_remote.dart';
import 'package:furnihome_ar/feature/rooms/data/remote/rooms_remote_impl.dart';
import 'package:furnihome_ar/feature/rooms/data/rooms_repository.dart';
import 'package:furnihome_ar/feature/rooms/data/rooms_repository_impl.dart';
import 'package:furnihome_ar/feature/rooms/screens/rooms_viewmodel.dart';
import 'package:furnihome_ar/feature/search/data/local/search_local.dart';
import 'package:furnihome_ar/feature/search/data/local/search_local_impl.dart';
import 'package:furnihome_ar/feature/search/data/remote/search_remote.dart';
import 'package:furnihome_ar/feature/search/data/remote/search_remote_impl.dart';
import 'package:furnihome_ar/feature/search/data/search_repository.dart';
import 'package:furnihome_ar/feature/search/data/search_repository_impl.dart';
import 'package:furnihome_ar/feature/search/screens/search_viewmodel.dart';
import 'package:furnihome_ar/routes/app_route.dart';

final GetIt locator = GetIt.instance;

Future setUpServiceLocator() async {
  locator.registerLazySingleton(() => AppRouter());

  //for api
  locator.registerLazySingleton(() => ApiClient());

  //home
  locator.registerLazySingleton<HomeLocal>(() => HomeLocalImpl());
  locator.registerLazySingleton<HomeRemote>(() => HomeRemoteImpl());
  locator.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());

  //categories
  locator.registerLazySingleton<CategoriesLocal>(() => CategoriesLocalImpl());
  locator.registerLazySingleton<CategoriesRemote>(() => CategoriesRemoteImpl());
  locator.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImpl());

  //rooms
  locator.registerLazySingleton<RoomsLocal>(() => RoomsLocalImpl());
  locator.registerLazySingleton<RoomsRemote>(() => RoomsRemoteImpl());
  locator.registerLazySingleton<RoomsRepository>(() => RoomsRepositoryImpl());

  //search
  locator.registerLazySingleton<SearchLocal>(() => SearchLocalImpl());
  locator.registerLazySingleton<SearchRemote>(() => SearchRemoteImpl());
  locator.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl());

  //product display
  locator.registerLazySingleton<ProductDetailLocal>(
      () => ProductDetailLocalImpl());
  locator.registerLazySingleton<ProductDetailRemote>(
      () => ProductDetailRemoteImpl());
  locator.registerLazySingleton<ProductDetailRepository>(
      () => ProductDetailRepositoryImpl());
}
