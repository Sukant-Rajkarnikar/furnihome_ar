import 'package:equatable/equatable.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/feature/rooms/model/rooms_model.dart';
import 'package:furnihome_ar/feature/search/data/model/search_response_model.dart';
import 'package:furnihome_ar/shared/enums/data_state_helper.dart';

class SearchScreenState extends Equatable {
  final String message;
  final DataConcreteState state;
  final SearchResponseModel? searchResponse;

  const SearchScreenState({
    required this.message,
    required this.state,
    required this.searchResponse,
  });

  const SearchScreenState.initial({
    this.message = "",
    this.state = DataConcreteState.initial,
    this.searchResponse,
  });

  SearchScreenState copyWith({
    String? message,
    DataConcreteState? state,
    SearchResponseModel? searchList,
  }) {
    return SearchScreenState(
      message: message ?? this.message,
      state: state ?? this.state,
      searchResponse: searchList ?? this.searchResponse,
    );
  }

  @override
  List<Object?> get props => [state, message, searchResponse];
}
