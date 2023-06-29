import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_app/providers/favorite_provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
          return ListView.builder(
            itemCount: favoriteProvider.favorites.length,
            itemBuilder: (context, index) {
              var item = favoriteProvider.favorites[index];

              return ListTile(
                title: Text(item.name),
                subtitle: Text(item.rating.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: () {
                    
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}