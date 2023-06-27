import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_app/providers/restaurant_provider.dart';
import 'package:submission_2_restaurant_app/ui/search_restaurant.dart';
import 'package:submission_2_restaurant_app/widgets/item_restaurant.dart';

const textColor = Colors.white;
const backgroundColor = Color.fromRGBO(33, 51, 99, 1);

class RestaurantList extends StatelessWidget {
  static String routeName = '/restaurant_list';

  const RestaurantList({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Restaurant Apps',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: textColor
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Look for various restaurants around you.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: textColor
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ChangeNotifierProvider<RestaurantProvider>(
                  create: (context) => RestaurantProvider()..fetchRestaurant(),
                  child: Consumer<RestaurantProvider>(
                    builder: (context, state, _) {
                      if (state.state == ResultState.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (state.state == ResultState.hasData) {
                          return ListView.builder(
                            itemCount: state.result.total,
                            itemBuilder: (context, index) {
                              final restaurant = state.result.restaurants[index];
                              return ItemRestaurant(restaurant: restaurant);
                            },
                          );
                        } else if (state.state == ResultState.noData) {
                          return const Center(
                            child: Text('No restaurants is found'),
                          );
                        } else {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wifi_off_outlined,
                                  size: 50,
                                ),
                                Text(
                                  'You are currently offline',
                                  style: TextStyle(
                                    fontSize: 15
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      }
                    },
                  ),
                )
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, SearchRestaurant.routeName);
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}