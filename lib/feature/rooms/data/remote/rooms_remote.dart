import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/feature/rooms/data/model/rooms_model.dart';

abstract class RoomsRemote {
  Future<List<RoomModel>> getRoomList();

}
