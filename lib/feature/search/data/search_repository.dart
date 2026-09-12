import 'package:furnihome_ar/feature/search/data/model/search_response_model.dart';

abstract class SearchRepository {
  Future<SearchResponseModel> searchFurniture(List<int> rooms, List<int> categories, String search, int offset);
}
