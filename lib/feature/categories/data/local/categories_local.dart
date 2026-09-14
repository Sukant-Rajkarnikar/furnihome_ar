import 'package:furnihome_ar/feature/categories/data/model/category_model.dart';

abstract class CategoriesLocal {
  Future<List<CategoryModel>> getCategoryList();
}
