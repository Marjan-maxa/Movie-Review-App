import 'package:flutter/cupertino.dart';
import 'package:movie_review_app/data/model/movie_model.dart';
import 'package:movie_review_app/data/services/api_service.dart';

import '../../domain/entities/movie.dart';

class MovieProvider extends ChangeNotifier{
  final ApiService _apiService = ApiService();
  List<Movie> _movies = [];
  List<Movie> get movies => _movies;
  List<Movie> _searchResults = [];
  List<Movie> get searchResults => _searchResults;
   MovieModel? _movieDetails ;
  MovieModel? get movieDetails => _movieDetails;
  bool _isLoading=false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTrendingMovies() async {
    _isLoading = true;
    notifyListeners();
    try{
      final movies=await _apiService.getTrendingMovies();
      _movies=movies;
      notifyListeners();
    }catch(e){
      _errorMessage='Failed to fetch trending movies: ${e.toString()}';
      notifyListeners();
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future<void> searchMovies(String query) async {
    _isLoading = true;
    notifyListeners();
    try {
      final results = await _apiService.searchMovies(query);
      _searchResults = results;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to search movies: ${e.toString()}';
      notifyListeners();
    }finally{
      _isLoading = false;
    notifyListeners();
  }
  }
  Future<MovieModel?> fetchMovieDetails(int movieId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final details = await _apiService.getMovieDetails(movieId);
      print('Api Response :${details}');
      _movieDetails=MovieModel.fromJson(details);
      notifyListeners();
    } catch (e) {
      print('error Message ${e}');
      _errorMessage = 'Failed to fetch movie details: ${e.toString()}';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return _movieDetails;
    }

}

