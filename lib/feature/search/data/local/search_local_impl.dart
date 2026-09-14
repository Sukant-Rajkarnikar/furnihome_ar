import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/categories/data/model/category_model.dart';
import 'package:furnihome_ar/feature/home/data/model/category_mapper.dart';
import 'package:furnihome_ar/feature/home/data/model/room_mapper.dart';
import 'package:furnihome_ar/feature/rooms/data/model/rooms_model.dart';
import 'package:furnihome_ar/feature/search/data/local/search_local.dart';
import 'package:furnihome_ar/shared/storage/sqlite/db_manager.dart';
import 'package:furnihome_ar/shared/storage/sqlite/entity/category_entity.dart';
import 'package:furnihome_ar/shared/storage/sqlite/entity/room_entity.dart';

class SearchLocalImpl implements SearchLocal {
  final DatabaseManager _databaseManager = locator<DatabaseManager>();

  @override
  Future<List<CategoryModel>> getCategories() async{
    List<CategoryEntity> categoryEntities = await _databaseManager.getCategoryDao().fetchAllCategories() ?? [];
    return CategoryMapper.mapFromEntity(categoryEntities);
  }

  @override
  Future<List<RoomModel>> getRooms() async{
    List<RoomEntity> roomEntities = await _databaseManager.getRoomDao().fetchAllRooms() ?? [];
    return RoomMapper.mapFromEntity(roomEntities);

  }

}
