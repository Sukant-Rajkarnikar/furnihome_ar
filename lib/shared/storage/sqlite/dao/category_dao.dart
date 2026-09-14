import 'package:floor/floor.dart';
import 'package:furnihome_ar/shared/storage/sqlite/entity/category_entity.dart';


@dao
abstract class CategoryDao{
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(CategoryEntity entity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<CategoryEntity> items);

  @Query('select * from categories')
  Future<List<CategoryEntity>?> fetchAllCategories();
}