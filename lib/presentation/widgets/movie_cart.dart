import 'package:flutter/material.dart';
import 'package:movie_review_app/domain/entities/movie.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class MovieCart extends StatelessWidget {
  const MovieCart({super.key, required this.movie, required this.onTap});
final Movie movie;
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16), // বর্ডার রেডিয়াস
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // শ্যাডোর রঙ
              blurRadius: 5, // শ্যাডোর ছড়ানো
              offset: const Offset(0, 3), // শ্যাডোর পজিশন (x, y)
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: .start,
          children: [

            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  '${AppStrings.imageBaseUrl}${movie.posterPath}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),

            // টেক্সট সেকশন
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.releaseDate,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,

                      fontSize: 14,
                    ),
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
