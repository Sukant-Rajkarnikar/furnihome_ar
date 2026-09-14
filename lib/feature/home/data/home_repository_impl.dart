import 'package:flutter/cupertino.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/categories/data/model/category_model.dart';
import 'package:furnihome_ar/feature/home/data/home_repository.dart';
import 'package:furnihome_ar/feature/home/data/local/home_local.dart';
import 'package:furnihome_ar/feature/home/data/remote/home_remote.dart';
import 'package:furnihome_ar/feature/rooms/data/model/rooms_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemote remote = locator<HomeRemote>();
  final HomeLocal local = locator<HomeLocal>();

  @override
  Future<List<FurnitureModel>> getFeaturedProducts() async {
    return await remote.getFeaturedProducts();
  }

  @override
  Future<List<FurnitureModel>> getNewProducts() async {
    return await remote.getNewProducts();
  }

  @override
  Future<List<FurnitureModel>> getArProducts() async {
    return await remote.getArProducts();
  }

  @override
  Future<List<RoomModel>> saveRoomCategoryData() async {
    List<RoomModel> rooms = await remote.getRoomList();
    List<CategoryModel> categories = await remote.getCategoryList();
    debugPrint("Here1");
    await local.saveRoomsCategories(rooms, categories);
    debugPrint("Here2");
    return rooms;
  }
}
