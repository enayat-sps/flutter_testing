import 'package:flutter/material.dart';
import 'package:flutter_testing/configs/routes.dart';
import '../models/favorites_model.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  static const routeName = AppRoutes.favoritesScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<FavoritesModel>(
        builder: (context, value, child) => ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemCount: value.itemsList.length,
          itemBuilder: (context, index) {
            return FavoriteListTile(
              item: value.itemsList[index],
            );
          },
        ),
      ),
    );
  }
}

class FavoriteListTile extends StatelessWidget {
  const FavoriteListTile({this.item, Key? key}) : super(key: key);
  final int? item;

  @override
  Widget build(BuildContext context) {
    final favoriteProvider =
        Provider.of<FavoritesModel>(context, listen: false);

    const removedMessage = SnackBar(
      content: Text('Removed from favorites.'),
      duration: Duration(seconds: 1),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[item! % Colors.primaries.length],
        ),
        title: Text(
          'Item $item',
          key: Key(
            item.toString(),
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            favoriteProvider.remove(item!);
            ScaffoldMessenger.of(context).showSnackBar(removedMessage);
          },
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
