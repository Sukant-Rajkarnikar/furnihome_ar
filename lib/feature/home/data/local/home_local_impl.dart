import 'package:flutter/cupertino.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/categories/data/model/category_model.dart';
import 'package:furnihome_ar/feature/home/data/local/home_local.dart';
import 'package:furnihome_ar/feature/home/data/model/category_mapper.dart';
import 'package:furnihome_ar/feature/home/data/model/room_mapper.dart';
import 'package:furnihome_ar/feature/rooms/data/model/rooms_model.dart';
import 'package:furnihome_ar/shared/storage/sqlite/db_manager.dart';
import 'package:furnihome_ar/shared/storage/sqlite/entity/category_entity.dart';

class HomeLocalImpl implements HomeLocal {
  final DatabaseManager _databaseManager = locator<DatabaseManager>();

  @override
  Future<void> saveRoomsCategories(
      List<RoomModel> rooms, List<CategoryModel> categories) async {
    List<CategoryEntity> entityList = CategoryMapper.mapToEntity(categories);
    await _databaseManager
        .getCategoryDao()
        .insertAllData(entityList);
    debugPrint("Here");
    await _databaseManager
        .getRoomDao()
        .insertAllData(RoomMapper.mapToEntity(rooms));
  }
}
