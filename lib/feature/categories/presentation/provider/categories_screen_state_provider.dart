import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/feature/categories/presentation/provider/state/categories_screen_notifier.dart';
import 'package:furnihome_ar/feature/categories/presentation/provider/state/categories_screen_state.dart';

final categoriesStateNotifierProvider =
    StateNotifierProvider<CategoriesScreenNotifier, CategoriesScreenState>(
  (ref) {
    return CategoriesScreenNotifier();
  },
);
