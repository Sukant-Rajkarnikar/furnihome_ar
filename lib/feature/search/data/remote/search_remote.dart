import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/feature/search/data/model/search_response_model.dart';

abstract class SearchRemote {
  Future<SearchResponseModel> searchFurniture(List<int> rooms, List<int> categories, String search, int offset);
}
