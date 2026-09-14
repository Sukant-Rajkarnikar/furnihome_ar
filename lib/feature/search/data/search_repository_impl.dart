import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/categories/data/model/category_model.dart';
import 'package:furnihome_ar/feature/rooms/data/model/rooms_model.dart';
import 'package:furnihome_ar/feature/search/data/local/search_local.dart';
import 'package:furnihome_ar/feature/search/data/model/search_response_model.dart';
import 'package:furnihome_ar/feature/search/data/remote/search_remote.dart';
import 'package:furnihome_ar/feature/search/data/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRemote remote = locator<SearchRemote>();
  SearchLocal local = locator<SearchLocal>();

  @override
  Future<SearchResponseModel> searchFurniture(List<int> rooms, List<int> categories, String search, int offset) async {
    return await remote.searchFurniture(rooms, categories, search, offset);
  }

  @override
  Future<List<RoomModel>> getRooms(){
    return local.getRooms();
  }

  @override
  Future<List<CategoryModel>> getCategories(){
    return local.getCategories();
  }
}
