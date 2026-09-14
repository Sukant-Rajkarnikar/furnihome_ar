import 'package:furnihome_ar/feature/rooms/data/model/rooms_model.dart';

abstract class RoomsLocal {
  Future<List<RoomModel>> getRoomList();
}
