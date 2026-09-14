import 'package:floor/floor.dart';
import 'package:furnihome_ar/shared/storage/sqlite/db_constants.dart';

@Entity(tableName: DatabaseConstants.roomsTable)
class RoomEntity {
  @PrimaryKey()
  @ColumnInfo(name: DatabaseConstants.roomId)
  final int id;

  @ColumnInfo(name: DatabaseConstants.roomTitle)
  final String title;

  @ColumnInfo(name: DatabaseConstants.roomImage)
  final String image;

  RoomEntity({
    required this.id,
    required this.title,
    required this.image,
  });
}
