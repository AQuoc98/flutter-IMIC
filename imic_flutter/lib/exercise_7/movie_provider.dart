import 'package:flutter/material.dart';

import 'movie_api.dart';
import 'movie_response.dart';

class MovieProvider extends ChangeNotifier {
  final MovieAPI api;

  MovieProvider(this.api);

  MovieResponse? popularMovieResponse;
  MovieResponse? topRatedMovieResponse;
  bool isLoading = false;

  Future<void> getPopularMovie({int page = 1}) async {
    isLoading = true;
    final result = (await api.getPopularMovies(page: page));
    if (popularMovieResponse == null) {
      popularMovieResponse = result;
    } else {
      popularMovieResponse = popularMovieResponse!.copyWith(
          page: result.page,
          results: [...popularMovieResponse!.results, ...result.results]);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getTopRatedMovie({int page = 1}) async {
    isLoading = true;
    final result = (await api.getTopRatedMovies(page: page));
    if (topRatedMovieResponse == null) {
      topRatedMovieResponse = result;
    } else {
      topRatedMovieResponse = topRatedMovieResponse!.copyWith(
          page: result.page,
          results: [...topRatedMovieResponse!.results, ...result.results]);
    }
    isLoading = false;
    notifyListeners();
  }
}
