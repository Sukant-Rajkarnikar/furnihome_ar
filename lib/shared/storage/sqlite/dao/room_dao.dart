import 'package:floor/floor.dart';
import 'package:furnihome_ar/shared/storage/sqlite/entity/room_entity.dart';


@dao
abstract class RoomDao{
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int?> insert(RoomEntity entity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int?>> insertAllData(List<RoomEntity> items);

  @Query('select * from rooms')
  Future<List<RoomEntity>?> fetchAllRooms();
}