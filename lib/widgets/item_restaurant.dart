import 'package:flutter/material.dart';
import 'package:submission_2_restaurant_app/data/model/restaurant.dart';
import 'package:submission_2_restaurant_app/ui/restaurant_detail.dart';

class ItemRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const ItemRestaurant({super.key, required this.restaurant});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: Image.network(
        restaurant.pictureId,
        width: 100,
      ),
      title: Text(
        restaurant.name,
        style: const TextStyle(
          color: Colors.white
        ),
      ),
      subtitle: Text(
        restaurant.city,
        style: const TextStyle(
          color: Colors.white
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName, arguments: restaurant.id);
      },
      trailing: Wrap(
        alignment: WrapAlignment.center,
        spacing: 5,
        children: [
          const Icon(
            Icons.star,
            size: 15,
            color: Colors.amberAccent
          ),
          Text(
            restaurant.rating.toString(),
            style: const TextStyle(
              color: Colors.amberAccent
            ),
          ),
        ],
      )
    );
  }
}