import 'package:furnihome_ar/feature/categories/data/model/category_model.dart';
import 'package:furnihome_ar/feature/rooms/data/model/rooms_model.dart';

abstract class SearchLocal {


  Future<List<RoomModel>> getRooms();
  Future<List<CategoryModel>> getCategories();
}
