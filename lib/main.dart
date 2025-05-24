import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_router.dart';
import 'data/api_service.dart';
import 'viewmodels/album_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    return BlocProvider(
      create: (_) => AlbumCubit(apiService),
      child: MaterialApp.router(
        title: 'Album Gallery',
        routerConfig: router,
        theme: ThemeData(
          primaryColor: Color(0xFF00C853), // Vibrant green
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF00C853),
            primary: Color(0xFF00C853),
            secondary: Color(0xFF00BFA5),
            background: Color(0xFF121212),
            brightness: Brightness.dark,
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
              shadows: [
                Shadow(
                  offset: Offset(1.5, 1.5),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.4),
                ),
              ],
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              color: Color(0xFFBDBDBD),
              height: 1.5,
            ),
          ),
          cardTheme: CardTheme(
            color: Color(0xFF1E1E1E),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            shadowColor: Colors.black.withOpacity(0.3),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF00C853),
              foregroundColor: Colors.black,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadowColor: Colors.green.withOpacity(0.3),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF121212),
            foregroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 1,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}