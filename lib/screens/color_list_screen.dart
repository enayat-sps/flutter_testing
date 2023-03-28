import 'package:flutter/material.dart';
import 'package:flutter_testing/configs/constants.dart';
import 'package:flutter_testing/configs/routes.dart';
import 'package:flutter_testing/models/favorites_model.dart';
import 'package:flutter_testing/screens/favorites_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ColorListScreen extends StatelessWidget {
  const ColorListScreen({Key? key}) : super(key: key);
  static const routeName = AppRoutes.colorListScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(colorListScreenTitle),
        actions: [
          TextButton.icon(
            onPressed: () {
              context.go('/${FavoritesScreen.routeName}');
            },
            icon: Icon(
              Icons.favorite_border,
              color: Theme.of(context).iconTheme.color,
            ),
            label: const Text(
              favoritesText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 100,
        cacheExtent: 20,
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemBuilder: (context, index) => colorItemTile(context, index),
      ),
    );
  }

  Widget colorItemTile(BuildContext context, int itemNo) {
    final favoriteProvider = Provider.of<FavoritesModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
        ),
        title: Text(
          '$itemTitle $itemNo',
          key: Key(itemNo.toString()),
        ),
        trailing: IconButton(
          onPressed: () {
            !favoriteProvider.itemsList.contains(itemNo)
                ? favoriteProvider.add(itemNo)
                : favoriteProvider.remove(itemNo);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  favoriteProvider.itemsList.contains(itemNo)
                      ? favoriteAdded
                      : favoriteRemoved,
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          key: Key(
            itemNo.toString(),
          ),
          icon: favoriteProvider.itemsList.contains(itemNo)
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
        ),
      ),
    );
  }
}
