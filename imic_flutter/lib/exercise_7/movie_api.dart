import 'package:dio/dio.dart';

import 'movie_response.dart';

class MovieAPI {
  final Dio dio;

  MovieAPI(this.dio);
  Future<MovieResponse> getPopularMovies({int page = 1}) async {
    final response = await dio
        .get<Map<String, dynamic>>('/popular?language=en-US&page=$page');
    return MovieResponse.fromJson(response.data!);
  }

  Future<MovieResponse> getTopRatedMovies({int page = 1}) async {
    final response = await dio
        .get<Map<String, dynamic>>('/top_rated?language=en-US&page=$page');
    return MovieResponse.fromJson(response.data!);
  }
}
