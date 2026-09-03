import 'package:equatable/equatable.dart';
import 'package:furnihome_ar/shared/enums/data_state_helper.dart';

class StateNotifierCommonState<T> extends Equatable {
  final DataConcreteState state;
  final T? data;
  final String? errorMessage;

  const StateNotifierCommonState({
    required this.state,
    this.data,
    this.errorMessage,
  });

  const StateNotifierCommonState.initial({
    this.state = DataConcreteState.initial,
    this.data,
    this.errorMessage,
  });

  StateNotifierCommonState<T> copyWith({
    DataConcreteState? state,
    T? data,
    String? errorMessage,
    String? message,
  }) {
    return StateNotifierCommonState<T>(
      state: state ?? this.state,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [state, data, errorMessage];
}
