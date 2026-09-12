import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnihome_ar/feature/search/presentation/provider/state/search_screen_notifier.dart';
import 'package:furnihome_ar/feature/search/presentation/provider/state/search_screen_state.dart';

final searchStateNotifierProvider =
StateNotifierProvider<SearchScreenNotifier, SearchScreenState>(
      (ref) {
    return SearchScreenNotifier();
  },
);
