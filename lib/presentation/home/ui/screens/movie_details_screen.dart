import 'package:flutter/material.dart';
import 'package:movie_review_app/presentation/home/ui/screens/search_screen.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../domain/entities/movie.dart';
import '../../../provider/movie_provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.movie});
  final Movie movie;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("Fetching details for movie ID: ${widget.movie.id}");
      fetchMovieDetails();
    });
  }

  void fetchMovieDetails() {
    Provider.of<MovieProvider>(
      context,
      listen: false,
    ).fetchMovieDetails(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    final movieProviderDetails = Provider.of<MovieProvider>(
      context,
    ).movieDetails;
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: AppColors.accent,
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
          backgroundColor: AppColors.primary,title: Text(widget.movie.title,style: const TextStyle(color: AppColors.textPrimary),)),
      body:  movieProviderDetails==null?const Center(child: CircularProgressIndicator(color: AppColors.accent,)): SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF546E7A),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                     Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                          child: Image.network(
                            '${AppStrings.imageBaseUrl}${widget.movie.backdropPath}',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Positioned(
                          left: 20,
                          bottom: -50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              '${AppStrings.imageBaseUrl}${widget.movie.posterPath}',
                              width: 110,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(

                                movieProviderDetails != null
                                    ? '${movieProviderDetails.runtime} min'
                                    : 'Loading...',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 30),
                              Icon(
                                Icons.calendar_month,
                                color: Colors.white70,
                                size: 20,
                              ),
                              Text(
                                widget.movie.releaseDate,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: .bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                widget.movie.voteAverage.toString(),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: .bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                widget.movie.overview,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: AppColors.textPrimary,
                  fontWeight: .w500,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              height: 260,
              margin: const EdgeInsets.all(25),
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade700,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  const Text(
                    "Ratings",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade800,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: .center,
                            children: List.generate(12, (index) {
                              List<double> heights = [
                                10,
                                10,
                                10,
                                15,
                                15,
                                25,
                                25,
                                80,
                                50,
                                70,
                                0,
                                0,
                              ];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: Container(
                                  width: 5,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade900,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: heights[index],
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      Column(
                        children: [
                          const Text(
                            "User rating",
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            '4.2',
                            style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
