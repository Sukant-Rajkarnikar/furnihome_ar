import 'package:furnihome_ar/feature/rooms/data/model/rooms_model.dart';
import 'package:furnihome_ar/shared/storage/sqlite/entity/room_entity.dart';

class RoomMapper {
  static List<RoomEntity> mapToEntity(List<RoomModel> rooms) {
    return rooms
        .map((room) => RoomEntity(
              id: room.id,
              title: room.title,
              image: room.imageName,
            ))
        .toList();
  }

  static List<RoomModel> mapFromEntity(List<RoomEntity> rooms) {
    return rooms
        .map((room) => RoomModel(
              id: room.id,
              title: room.title,
              imageName: room.image,
            ))
        .toList();
  }
}
