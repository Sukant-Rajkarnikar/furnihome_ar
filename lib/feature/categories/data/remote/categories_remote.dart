import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/feature/categories/data/model/category_model.dart';
abstract class CategoriesRemote {
  Future<List<CategoryModel>> getCategoryList();
}
