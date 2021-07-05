import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';
import 'package:tema/src/actions/get_movies.dart';
import 'package:tema_yts/src/actions/get_movies.dart';
import 'package:tema_yts/src/actions/set.dart';
import 'package:tema_yts/src/models/app_state.dart';
import 'package:tema_yts/src/models/movie.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
      (AppState state, dynamic action) {
    print(action);
    return state;
  },
  TypedReducer<AppState, GetMovies>(_getMovies),
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
  TypedReducer<AppState, GetMoviesError>(_getMoviesError),
  TypedReducer<AppState, SetSelectedMovie>(_setSelectedMovie),
]);

AppState _getMovies(AppState state, GetMovies action) {
  return state.rebuild((AppStateBuilder b) {
    b.isLoading = true;
  });
}

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    print('page is now: ${state.page + 1}');
    b
      ..movies.addAll(action.movies);
      ..isLoading = false;
      ..page = state.page + 1;
  });
}

AppState _getMoviesError(AppState state, GetMoviesError action) {
  return state.rebuild((AppStateBuilder b) {
    b
      ..isLoading = false
      ..error = '${action.error}';
  });
}

AppState _setSelectedMovie(AppState state, SetSelectedMovie action) {
  return state.rebuild((AppStateBuilder b){
    b.movies;
  });
}