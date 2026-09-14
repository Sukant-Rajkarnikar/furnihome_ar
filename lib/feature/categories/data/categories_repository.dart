import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/feature/categories/data/model/category_model.dart';

abstract class CategoriesRepository {
  Future<List<CategoryModel>> getCategoryList();
}
