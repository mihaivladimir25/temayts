import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart';
import 'package:tema_yts/src/middleware/middleware.dart';
import 'package:tema_yts/src/models/app_state.dart';
import 'package:tema_yts/src/reducer/reducer.dart';

void main(){
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

  runApp(YtsApp(store: store));
}

class MyApp extends StatelessWidget{
  const YtsApp({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context){
    return StoreProvider<AppState>(
      store: store,
      child: const MaterialApp(
        home: HomePage(),
        theme: ThemeData.dark(),
        routes: <String, WidgetBuilder>{
          '/details':(BuildContext context) {
            return const MovieDetails();
          }
        },
      ),
    );
  }
}