import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../provider/movie_provider.dart';
import '../../../widgets/movie_cart.dart';
import 'movie_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.accent),
        backgroundColor: AppColors.primary,
        title: const Text('Search',style: TextStyle(color: AppColors.textPrimary),),
      ),

      body: Column(
        children: [
          TextField(
            style: TextStyle(
              color: AppColors.accent,
            ),
            controller: _searchController,
            onChanged: (query) {
              Provider.of<MovieProvider>(
                context,
                listen: false,
              ).searchMovies(query);
            },
            decoration: InputDecoration(
              iconColor: AppColors.accent,
              hintText: 'Search movies...',
              hintStyle: const TextStyle(color: AppColors.accent),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.accent),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.accent),
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _searchController.clear();
                  Provider.of<MovieProvider>(
                    context,
                    listen: false,
                  ).searchResults.clear();
                },
                icon: const Icon(Icons.close),
              ),
            ),

          ),
          Expanded(
            child: Consumer<MovieProvider>(
              builder: (context, movieProvider, child) {
                if (movieProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator(
                    color: AppColors.accent,
                  ));
                }
                if (movieProvider.errorMessage != null) {
                  return Center(child: Text(movieProvider.errorMessage!));
                }
                return GridView.builder(
                    itemCount: movieProvider.searchResults.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.67,
                    ),
                    itemBuilder: (context, index) {
                      return MovieCart(
                        movie: movieProvider.searchResults[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailsScreen(movie: movieProvider.searchResults[index],),
                            ),
                          );
                        },
                      ).animate().fadeIn(duration: 1000.ms,delay: (index*100).ms).slideY(begin: 0.5,end: 0,duration: 600.ms,curve: Curves.easeOutBack);
                    }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
