import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/categories/data/categories_repository.dart';
import 'package:furnihome_ar/feature/categories/presentation/provider/state/categories_screen_state.dart';
import 'package:furnihome_ar/shared/enums/data_state_helper.dart';
import 'package:furnihome_ar/shared/exceptions/parse_error.dart';

class CategoriesScreenNotifier extends StateNotifier<CategoriesScreenState> {
  CategoriesScreenNotifier() : super(const CategoriesScreenState.initial());

  static final CategoriesRepository _repository =
      locator<CategoriesRepository>();

  Future<void> getCategoriesScreenData() async {
    state = state.copyWith(state: DataConcreteState.loading);
    try {
      final categories = await _repository.getCategoryList();
      state = state.copyWith(
        state: DataConcreteState.loaded,
        categories: categories,
      );
    } catch (e) {
      state = state.copyWith(
          state: DataConcreteState.failure, message: parseError(e));
    }
  }
}
