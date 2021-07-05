import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tema/src/models/movie.dart';
import 'package:tema_yts/src/actions/get_movies.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final isLoading = StoreProvider.of<AppState>(context).state.isLoading;
    final double max = _controller.position.maxScrollExtent;
    final double offset = _controller.offset;
    final double delta = max - offset;
    final double screenHeight = MediaQuery.of(context).size.height;
    final threshold = screenHeight * 0.2;

    if(delta < threshold && !isLoading) {
      store.dispatch(const GetMovies());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: <Widget>[
          isLoadingContainer(
            builder: (BuildContext context, bool isLoading) {
              if(isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }

              return IconButton(
                icon: const Icon(Icons.movie),
                onPressed: (){
                  final Store<AppState> store = StoreProvider.of<AppState>(context);
                  store.dispatch(const GetMovies());
                },
              );
            },
          ),
        ],
      ),
      body: MoviesContainer(
          builder: (BuildContext context, List<Movie> movies) {
            return IsLoadingContainer(
                builder: (BuildContext context, bool isLoading){
                  if(isLoading && movies.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.70,
                    ),
                    controller: _controller,
                    itemCount: movies.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    cacheExtent: MediaQuery.of(context).size.height,
                    itemBuilder: (BuildContext context, int index){
                      final Movie movie = movies[index];

                      return Container(
                        height: 400,
                        child: GridTile(
                          child: Image.network(movie.image),
                          footer: GridTileBar(
                            backgroundColor: Colors.black,
                            title: Text(movie.title),
                        ),
                        ),
                      );
                      },
                  );
                },
            );
          },
      ),
    );
  }
}