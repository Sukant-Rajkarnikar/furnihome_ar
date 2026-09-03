// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: (json['category_id'] as num).toInt(),
      categoryName: json['category_name'] as String,
      imageName: json['category_image'] as String,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'category_id': instance.id,
      'category_name': instance.categoryName,
      'category_image': instance.imageName,
    };
