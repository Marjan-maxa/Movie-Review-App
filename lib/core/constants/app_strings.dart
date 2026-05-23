import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppStrings {
  static const String appName = 'Movie Review App';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  // You should store your TMDB authorization key here.
  // For security, this is typically loaded at runtime via environment variables natively.
  static final String ?authorizationToken =dotenv.env['TMDB_TOKEN'];
}