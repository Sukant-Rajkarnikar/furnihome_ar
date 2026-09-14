import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/categories/data/local/categories_local.dart';
import 'package:furnihome_ar/feature/categories/data/model/category_model.dart';
import 'package:furnihome_ar/feature/home/data/model/category_mapper.dart';
import 'package:furnihome_ar/shared/storage/sqlite/db_manager.dart';
import 'package:furnihome_ar/shared/storage/sqlite/entity/category_entity.dart';

class CategoriesLocalImpl implements CategoriesLocal {
  final DatabaseManager _databaseManager = locator<DatabaseManager>();

  @override
  Future<List<CategoryModel>> getCategoryList() async {
    List<CategoryEntity> entityList =
        await _databaseManager.getCategoryDao().fetchAllCategories() ?? [];
    return CategoryMapper.mapFromEntity(entityList);
  }
}
