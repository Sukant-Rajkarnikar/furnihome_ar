import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/home/data/model/room_mapper.dart';
import 'package:furnihome_ar/feature/rooms/data/local/rooms_local.dart';
import 'package:furnihome_ar/feature/rooms/data/model/rooms_model.dart';
import 'package:furnihome_ar/shared/storage/sqlite/db_manager.dart';
import 'package:furnihome_ar/shared/storage/sqlite/entity/room_entity.dart';

class RoomsLocalImpl implements RoomsLocal {
  final DatabaseManager _databaseManager = locator<DatabaseManager>();

  @override
  Future<List<RoomModel>> getRoomList() async {
    List<RoomEntity> entityList =
        await _databaseManager.getRoomDao().fetchAllRooms() ?? [];
    return RoomMapper.mapFromEntity(entityList);
  }
}
