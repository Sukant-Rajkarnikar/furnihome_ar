enum DataConcreteState {
  initial,
  loading,
  loadingMsg,
  loaded,
  failure,
  fetchingMore,
  fetchedAllData,
  loadingOverlay,
  failureOverlay,
  fetchedAllProducts
}

isLoadingState(DataConcreteState state) {
  return state == DataConcreteState.loading ||
      state == DataConcreteState.loadingMsg;
}

isFetchingMoreState(DataConcreteState state) {
  return state == DataConcreteState.fetchingMore;
}

isLoadedState(DataConcreteState state) {
  return state == DataConcreteState.loaded;
}

isFetchedAllState(DataConcreteState state) {
  return state == DataConcreteState.fetchedAllData;
}

isFailureState(DataConcreteState state) {
  return state == DataConcreteState.failure;
}

isPrevLoadingNowLoaded(
    DataConcreteState? prevState, DataConcreteState currState) {
  if (prevState == null) {
    prevState = DataConcreteState.initial;
  } else {
    prevState = prevState;
  }
  return (prevState == DataConcreteState.loading ||
          prevState == DataConcreteState.loadingMsg) &&
      currState == DataConcreteState.loaded;
}

isPrevLoadingNowFailure(
    DataConcreteState? prevState, DataConcreteState currState) {
  if (prevState == null) {
    prevState = DataConcreteState.initial;
  } else {
    prevState = prevState;
  }
  return (prevState == DataConcreteState.loading ||
          prevState == DataConcreteState.loadingMsg) &&
      currState == DataConcreteState.failure;
}
