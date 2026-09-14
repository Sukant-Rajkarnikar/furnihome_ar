import 'package:furnihome_ar/feature/categories/data/model/category_model.dart';
import 'package:furnihome_ar/feature/rooms/data/model/rooms_model.dart';
import 'package:furnihome_ar/feature/search/data/model/search_response_model.dart';

abstract class SearchRepository {
  Future<SearchResponseModel> searchFurniture(List<int> rooms, List<int> categories, String search, int offset);

  Future<List<RoomModel>> getRooms();
  Future<List<CategoryModel>> getCategories();
}
