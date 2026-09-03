import 'dart:convert';

import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/home/data/remote/home_remote.dart';
import 'package:furnihome_ar/feature/rooms/model/rooms_model.dart';
import 'package:furnihome_ar/shared/network/api_constants.dart';
import 'package:furnihome_ar/shared/network/dio/base_list_response.dart';
import 'package:furnihome_ar/shared/network/errors.dart';
import 'package:furnihome_ar/shared/network/http_client.dart';
import 'package:furnihome_ar/shared/network/not_null_mapper.dart';

class HomeRemoteImpl implements HomeRemote {
  static final ApiClient _apiClient = locator<ApiClient>();

  @override
  Future<List<FurnitureModel>> getFeaturedProducts() async {
    try {
      var result = await _apiClient.dio.get(ApiConstants.furnituresFeatured);
      var baseResponse = BaseListResponse<FurnitureModel>.fromJson(
          json.decode(result.toString()), (data) {
        return data
            .map((response) => FurnitureModel.fromJson(response))
            .toList();
      });
      return notNullMapperListRest(baseResponse);
    } on Exception catch (exception) {
      throw FailedResponseException(exception.toString());
    }
  }

  @override
  Future<List<FurnitureModel>> getNewProducts() async {
    try {
      var result = await _apiClient.dio.get(ApiConstants.furnituresLatest);
      var baseResponse = BaseListResponse<FurnitureModel>.fromJson(
          json.decode(result.toString()), (data) {
        return data
            .map((response) => FurnitureModel.fromJson(response))
            .toList();
      });
      return notNullMapperListRest(baseResponse);
    } on Exception catch (exception) {
      throw FailedResponseException(exception.toString());
    }
  }

  @override
  Future<List<FurnitureModel>> getArProducts() async {
    try {
      var result = await _apiClient.dio.get(ApiConstants.furnituresAr);
      var baseResponse = BaseListResponse<FurnitureModel>.fromJson(
          json.decode(result.toString()), (data) {
        return data
            .map((response) => FurnitureModel.fromJson(response))
            .toList();
      });
      return notNullMapperListRest(baseResponse);
    } on Exception catch (exception) {
      throw FailedResponseException(exception.toString());
    }
  }

  @override
  Future<List<RoomModel>> getRoomList() async {
    try {
      var result = await _apiClient.dio.get(ApiConstants.rooms);
      var baseResponse = BaseListResponse<RoomModel>.fromJson(
          json.decode(result.toString()), (data) {
        return data.map((response) => RoomModel.fromJson(response)).toList();
      });
      return notNullMapperListRest(baseResponse);
    } on Exception catch (exception) {
      throw FailedResponseException(exception.toString());
    }
  }
}
