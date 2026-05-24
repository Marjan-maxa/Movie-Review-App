import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppStrings {
  static const String appName = 'Movie Review App';
  static const String splashTest =  'Track films you’ve\nwatched. Save those you\nwant to see';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  // You should store your TMDB authorization key here.
  // For security, this is typically loaded at runtime via environment variables natively.
  static  String ?authorizationToken =dotenv.env['TMDB_TOKEN'];
}