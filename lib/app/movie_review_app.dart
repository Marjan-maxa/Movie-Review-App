import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation/home/splash/splash_screen.dart';
import '../presentation/provider/movie_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
