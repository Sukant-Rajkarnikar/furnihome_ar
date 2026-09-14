import 'package:equatable/equatable.dart';
import 'package:furnihome_ar/feature/categories/data/model/category_model.dart';
import 'package:furnihome_ar/feature/rooms/data/model/rooms_model.dart';
import 'package:furnihome_ar/feature/search/data/model/search_response_model.dart';
import 'package:furnihome_ar/shared/enums/data_state_helper.dart';

class SearchScreenState extends Equatable {
  final String message;
  final DataConcreteState state;
  final SearchResponseModel? searchResponse;
  final List<RoomModel>? rooms;
  final List<CategoryModel>? categories;

  const SearchScreenState({
    required this.message,
    required this.state,
    required this.searchResponse,
    this.rooms,
    this.categories,
  });

  const SearchScreenState.initial({
    this.message = "",
    this.state = DataConcreteState.initial,
    this.searchResponse,
    this.rooms,
    this.categories,
  });

  SearchScreenState copyWith({
    String? message,
    DataConcreteState? state,
    SearchResponseModel? searchList,
    List<RoomModel>? rooms,
    List<CategoryModel>? categories,
  }) {
    return SearchScreenState(
      message: message ?? this.message,
      state: state ?? this.state,
      searchResponse: searchList ?? this.searchResponse,
      rooms: rooms ?? this.rooms,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [state, message, searchResponse, rooms, categories];
}