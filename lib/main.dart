import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:tema_yts/src/actions/get_movies.dart';
import 'package:tema_yts/src/middleware/middleware.dart';
import 'package:tema_yts/src/models/app_state.dart';
import 'package:tema_yts/src/presentation/home_page.dart';
import 'package:tema_yts/src/reducer/reducer.dart';

import 'src/data/movies_api.dart';

void main() {
  const String apiUrl = 'https://yts.mx/api/v2';
  final Client client = Client();
  final MoviesApi moviesApi = MoviesApi(apiUrl: apiUrl, client: client);
  final AppMiddleware appMiddleware = AppMiddleware(moviesApi: moviesApi);
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: AppState(),
    middleware: appMiddleware.middleware,
  );
  store.dispatch(const GetMovies());

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: HomePage(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
