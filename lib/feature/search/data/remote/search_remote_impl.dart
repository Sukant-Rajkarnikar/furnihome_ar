import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/search/data/model/search_response_model.dart';
import 'package:furnihome_ar/feature/search/data/remote/search_remote.dart';
import 'package:furnihome_ar/shared/network/api_constants.dart';
import 'package:furnihome_ar/shared/network/dio/base_list_response.dart';
import 'package:furnihome_ar/shared/network/errors.dart';
import 'package:furnihome_ar/shared/network/http_client.dart';
import 'package:furnihome_ar/shared/network/not_null_mapper.dart';

class SearchRemoteImpl implements SearchRemote {
  static final ApiClient _apiClient = locator<ApiClient>();

  @override
  Future<SearchResponseModel> searchFurniture(List<int> rooms, List<int> categories, String search, int offset) async {
    try {
      var params = {
        "limit": 10,
        "offset": offset,
        "roomIds": rooms,
        "categoryIds": categories,
        "searchText": search
      };

      var result = await _apiClient.dio.post(
        ApiConstants.furnitureSearch,
        data: params,
      );

      final responseData = result.data is String ? json.decode(result.data) : result.data;
      debugPrint("Furniture Search Params: $params");
      debugPrint("Furniture Search Response: $responseData");

      var baseResponse = BaseListResponse<FurnitureModel>.fromJson(
          responseData,
              (data) {
            return (data)
                .map((response) => FurnitureModel.fromJson(response as Map<String, dynamic>))
                .toList();
          }
      );

      List<FurnitureModel> products = notNullMapperListRest(baseResponse);

      return SearchResponseModel(
        limit: responseData['limit'] as int,
        offset: responseData['offset'] as int,
        count: responseData['count'] as int,
        products: products,
      );
    } on Exception catch (exception) {
      throw FailedResponseException(exception.toString());
    }
  }
}