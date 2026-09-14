import 'package:furnihome_ar/feature/categories/model/category_model.dart';
import 'package:furnihome_ar/feature/rooms/data/model/rooms_model.dart';

abstract class HomeLocal {

  Future<void> saveRoomsCategories(List<RoomModel> rooms, List<CategoryModel> categories);
}
