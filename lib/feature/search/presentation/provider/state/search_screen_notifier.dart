import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/search/data/search_repository.dart';
import 'package:furnihome_ar/feature/search/presentation/provider/state/search_screen_state.dart';
import 'package:furnihome_ar/shared/enums/data_state_helper.dart';
import 'package:furnihome_ar/shared/exceptions/parse_error.dart';

class SearchScreenNotifier extends StateNotifier<SearchScreenState> {
  SearchScreenNotifier() : super(const SearchScreenState.initial());

  static final SearchRepository _repository = locator<SearchRepository>();

  Future<void> searchFurniture(
      List<int> rooms, List<int> categories, String search, int offset) async {
    if (offset == 0) {
      state = state.copyWith(state: DataConcreteState.loading);
    }

    try {
      final response =
      await _repository.searchFurniture(rooms, categories, search, offset);

      if (!mounted) return;

      if (offset > 0 && state.searchResponse != null) {
        response.products = [
          ...state.searchResponse!.products,
          ...response.products
        ];
      }

      state = state.copyWith(
          state: DataConcreteState.loaded, searchList: response);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(
          state: DataConcreteState.failure, message: parseError(e));
    }
  }

  Future<void> getRoomsAndCategories() async {
    try {
      final rooms = await _repository.getRooms();
      final categories = await _repository.getCategories();

      if (!mounted) return;

      state = state.copyWith(
        rooms: rooms,
        categories: categories,
      );
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(
          state: DataConcreteState.failure, message: parseError(e));
    }
  }
}