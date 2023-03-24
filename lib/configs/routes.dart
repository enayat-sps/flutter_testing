import 'package:flutter_testing/screens/color_list_screen.dart';
import 'package:flutter_testing/screens/favorites_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const counterScreen = '/counter-screen';
  static const booksScreen = '/books-screen';
  static const colorListScreen = '/';
  static const favoritesScreen = 'favorite-screen';
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: ColorListScreen.routeName,
      builder: (context, state) {
        return const ColorListScreen();
      },
      routes: [
        GoRoute(
          path: FavoritesScreen.routeName,
          builder: (context, state) {
            return const FavoritesScreen();
          },
        ),
      ],
    ),
  ],
);
