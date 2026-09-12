import 'package:furnihome_ar/common_models/furniture_model.dart';

class SearchResponseModel {
  int limit;
  int offset;
  int count;
  List<FurnitureModel> products;

  SearchResponseModel({required this.limit,required this.offset,required this.count,required this.products});
}
