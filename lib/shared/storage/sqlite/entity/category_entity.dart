import 'package:floor/floor.dart';
import 'package:furnihome_ar/shared/storage/sqlite/db_constants.dart';

@Entity(tableName: DatabaseConstants.categoriesTable)
class CategoryEntity {
  @PrimaryKey()
  @ColumnInfo(name: DatabaseConstants.categoryId)
  final int id;

  @ColumnInfo(name: DatabaseConstants.categoryTitle)
  final String title;

  @ColumnInfo(name: DatabaseConstants.categoryImage)
  final String image;

  CategoryEntity({
    required this.id,
    required this.title,
    required this.image,
  });
}
