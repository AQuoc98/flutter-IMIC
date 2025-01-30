import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movie_api.dart';
import 'movie_provider.dart';
import 'movie_response.dart';

final dio =
    Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3/movie', headers: {
  'Content-Type': 'application/json',
  'Authorization':
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2NTMwMmQ5ZmQ1N2RkYTNlYTJiYTg2ZjM3MGFiNmI3ZiIsInN1YiI6IjVkNmRlM2E0NjU2ODZlMDkxNzg3ZWQwNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.f0LRHeQrPh_B9G8bqsVN6TH6E8H95ftioPovN_KkbD0'
}));
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final api = MovieAPI(dio);
    return MaterialApp(
      title: 'Material App',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MovieProvider(api),
          )
        ],
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MovieTab(
      key: PageStorageKey(MovieType.popular),
      type: MovieType.popular,
    ),
    MovieTab(
      key: PageStorageKey(MovieType.topRated),
      type: MovieType.topRated,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Popular',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'TopRated',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ));
  }
}

enum MovieType {
  popular,
  topRated,
}

class MovieTab extends StatefulWidget {
  const MovieTab({super.key, required this.type});
  final MovieType type;

  @override
  State<MovieTab> createState() => _MovieTabState();
}

class _MovieTabState extends State<MovieTab> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    _loadData();

    controller.addListener(_handleScrolling);
    super.initState();
  }

  void _loadData({int page = 1}) {
    if (widget.type == MovieType.popular) {
      context.read<MovieProvider>().getPopularMovie(page: page);
    } else {
      context.read<MovieProvider>().getTopRatedMovie(page: page);
    }
  }

  @override
  void dispose() {
    controller.removeListener(_handleScrolling);
    super.dispose();
  }

  void _handleScrolling() {
    if (controller.offset >= controller.position.maxScrollExtent) {
      //load more
      final provider = context.read<MovieProvider>();
      if (provider.isLoading) {
        print('is loading');
        return;
      }
      int page = widget.type == MovieType.popular
          ? provider.popularMovieResponse?.page ?? 1
          : provider.topRatedMovieResponse?.page ?? 1;
      _loadData(page: page + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<MovieProvider, MovieResponse?>(
      selector: (p0, p1) => widget.type == MovieType.popular
          ? p1.popularMovieResponse
          : p1.topRatedMovieResponse,
      builder: (context, value, child) {
        if (value == null) {
          return const CircularProgressIndicator();
        }
        return ListView.separated(
            controller: controller,
            itemBuilder: (context, index) {
              final movie = value.results[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${movie.backdropPath}'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.brown, width: 0.5)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          movie.overview,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(height: 2, fontSize: 15),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: value.results.length);
      },
    );
  }
}
// // // // // //
