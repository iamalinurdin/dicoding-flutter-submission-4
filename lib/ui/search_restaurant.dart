import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_app/providers/restaurant_provider.dart';
import 'package:submission_2_restaurant_app/widgets/item_restaurant.dart';

class SearchRestaurant extends StatefulWidget {
  static const routeName = '/search_restaurant';

  const SearchRestaurant({super.key});

  @override
  State<SearchRestaurant> createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  final List result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text('Search'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => RestaurantProvider(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Find your favourite restaurant here.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Consumer<RestaurantProvider>(
                  builder: (context, state, _) {
                    return TextField(
                      onChanged: (value) async {
                        Provider.of<RestaurantProvider>(context, listen: false).searchRestaurant(value);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(23, 74, 98, 163),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none
                        ),
                        hintText: 'ex: restaurant name, menu...',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12
                        ),
                        // suffixIcon: IconButton(
                        //   icon: const Icon(Icons.clear),
                        //   onPressed: () {}, 
                        // ),
                        // suffixIconColor: Colors.white,
                      ),
                      style: const TextStyle(
                        color: Colors.white
                      ),
                    );
                  }
                ),
                const SizedBox(height: 10),
                Expanded(
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
                          return Center(
                            child: Text(state.message),
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
                  )
                ),
              ]
            ),
          )
        ),
      ),
    );
  }
}