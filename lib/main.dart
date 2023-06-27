import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_app/data/model/restaurant.dart';
import 'package:submission_2_restaurant_app/providers/restaurant_provider.dart';
import 'package:submission_2_restaurant_app/ui/restaurant_detail.dart';
import 'package:submission_2_restaurant_app/ui/restaurant_list.dart';
import 'package:submission_2_restaurant_app/ui/add_review.dart';
import 'package:submission_2_restaurant_app/ui/review_list.dart';
import 'package:submission_2_restaurant_app/ui/search_restaurant.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestaurantProvider())
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        scaffoldBackgroundColor: const Color.fromRGBO(33, 51, 99, 1),
      ),
      home: const RestaurantList(),
      initialRoute: RestaurantList.routeName,
      routes: {
        RestaurantList.routeName: (context) => const RestaurantList(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(id: ModalRoute.of(context)?.settings.arguments as String),
        AddReview.routeName: (context) => AddReview(restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant),
        ReviewList.routeName:(context) => ReviewList(reviews: ModalRoute.of(context)?.settings.arguments),
        SearchRestaurant.routeName: (context) => const SearchRestaurant()
      },
    );
  }
}