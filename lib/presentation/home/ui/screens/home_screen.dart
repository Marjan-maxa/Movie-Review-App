import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:movie_review_app/core/constants/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../provider/movie_provider.dart';
import '../../../widgets/movie_cart.dart';
import 'movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
      () => Provider.of<MovieProvider>(
        context,
        listen: false,
      ).fetchTrendingMovies(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: AppColors.primary,
        actions: [
          Image.asset('assets/CINEPHILER.png'),
          const SizedBox(width: 170),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: AppColors.accent,
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 16),


        ],
        leading:CircleAvatar(
        radius: 30,
          backgroundColor: Colors.white,
        backgroundImage: AssetImage('assets/movie_app_logo.png'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
              itemCount: movieProvider.movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.67,
              ),
              itemBuilder: (context, index) {
                return MovieCart(
                  movie: movieProvider.movies[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MovieDetailsScreen(),
                      ),
                    );
                  },
                ).animate().fadeIn(duration: 1000.ms,delay: (index*100).ms).slideY(begin: 0.5,end: 0,duration: 600.ms,curve: Curves.easeOutBack);
              }
            );
          },
        ),
      ),
    );
  }
}
 // 1:2:48 after start