import 'package:equatable/equatable.dart';
import 'package:furnihome_ar/feature/categories/data/model/category_model.dart';
import 'package:furnihome_ar/shared/enums/data_state_helper.dart';

class CategoriesScreenState extends Equatable {
  final String message;
  final DataConcreteState state;
  final List<CategoryModel> categories;

  const CategoriesScreenState({
    required this.message,
    required this.state,
    required this.categories,
  });

  const CategoriesScreenState.initial({
    this.message = "",
    this.state = DataConcreteState.initial,
    this.categories = const [],
  });

  CategoriesScreenState copyWith({
    String? message,
    DataConcreteState? state,
    List<CategoryModel>? categories,
  }) {
    return CategoriesScreenState(
      message: message ?? this.message,
      state: state ?? this.state,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [state, message, categories];
}
