import 'package:furnihome_ar/feature/categories/data/model/category_model.dart';
import 'package:furnihome_ar/shared/storage/sqlite/entity/category_entity.dart';

class CategoryMapper {
  static List<CategoryEntity> mapToEntity(List<CategoryModel> categories) {
    return categories
        .map((category) => CategoryEntity(
              id: category.id,
              title: category.categoryName,
              image: category.imageName,
            ))
        .toList();
  }

  static List<CategoryModel> mapFromEntity(List<CategoryEntity> categories) {
    return categories
        .map((category) => CategoryModel(
              id: category.id,
              categoryName: category.title,
              imageName: category.image,
            ))
        .toList();
  }
}
