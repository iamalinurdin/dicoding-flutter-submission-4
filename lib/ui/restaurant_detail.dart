import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_app/providers/restaurant_provider.dart';
import 'package:submission_2_restaurant_app/ui/add_review.dart';
import 'package:submission_2_restaurant_app/ui/review_list.dart';
import 'package:submission_2_restaurant_app/widgets/item_menu.dart';

class RestaurantDetailPage extends StatelessWidget {
  static String routeName = '/restaurant_detail';
  final String id;

  const RestaurantDetailPage({
    super.key, 
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ChangeNotifierProvider<RestaurantProvider>(
              create: (context) => RestaurantProvider()..fetchDetail(id),
              child: Consumer<RestaurantProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),  
                    );
                  } else {
                    if (state.state == ResultState.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 250,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(state.restaurant.pictureId),
                                  fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            state.restaurant.name,
                            style: const TextStyle(
                              fontSize: 30
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Categories: ${state.restaurant.categories}',
                            style: const TextStyle(
                              fontSize: 15
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Card(
                                  color: Colors.lightBlueAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              size: 18,
                                              color: Colors.black87
                                            ),
                                            Text(
                                              state.restaurant.city,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black87
                                              ),
                                            )
                                          ],
                                        ),
                                        const Text(
                                          'Location',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w700
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  color: Colors.lightBlueAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.star_border_outlined,
                                              size: 18,
                                              color: Colors.black87
                                            ),
                                            Text(
                                              '${state.restaurant.rating.toString()}/5',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black87
                                              ),
                                            )
                                          ],
                                        ),
                                        const Text(
                                          'Ratings',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w700
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, ReviewList.routeName, arguments: state.restaurant.reviews);
                                },
                                child: const Text('Reviews')
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AddReview.routeName, arguments: state.restaurant);
                                },
                                child: const Text('Add Review')
                              )
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          // const SizedBox(height: 10),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            state.restaurant.description,
                            style: const TextStyle(
                              fontSize: 15
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          const Text(
                            'Foods',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                          const SizedBox(height: 20),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75,
                            ), 
                            itemCount: state.restaurant.menus['foods'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemMenu(
                                menu: state.restaurant.menus['foods'][index]['name'],
                                image: 'images/food-vertical.jpg',
                              );
                            },
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          const Text(
                            'Beverages',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                          const SizedBox(height: 20),
                          GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75,
                            ), 
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.restaurant.menus['drinks'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemMenu(
                                menu: state.restaurant.menus['drinks'][index]['name'],
                                image: 'images/beverage-vertical.jpg',
                              );
                            },
                          ),
                        ]
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
            ),
          ),
        ),
      ),
    );
  }
}