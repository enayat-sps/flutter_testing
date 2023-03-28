import 'package:flutter/material.dart';
import 'package:flutter_testing/configs/constants.dart';
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
        builder: (context, value, child) => value.itemsList.isEmpty
            ? Center(
                child: Text(
                  noFavorite,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: value.itemsList.length,
                itemBuilder: (context, index) {
                  return FavoriteListTile(
                    itemNo: value.itemsList[index],
                  );
                },
              ),
      ),
    );
  }
}

class FavoriteListTile extends StatelessWidget {
  const FavoriteListTile({this.itemNo, Key? key}) : super(key: key);
  final int? itemNo;

  @override
  Widget build(BuildContext context) {
    final favoriteProvider =
        Provider.of<FavoritesModel>(context, listen: false);

    const removedMessageSnack = SnackBar(
      content: Text(favoriteRemoved),
      duration: Duration(seconds: 1),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo! % Colors.primaries.length],
        ),
        title: Text(
          '$itemTitle $itemNo',
          key: Key(
            itemNo.toString(),
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            favoriteProvider.remove(itemNo!);
            ScaffoldMessenger.of(context).showSnackBar(removedMessageSnack);
          },
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
