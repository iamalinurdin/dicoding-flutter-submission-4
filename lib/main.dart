import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_2_restaurant_app/data/db/favorite_db.dart';
import 'package:submission_2_restaurant_app/data/model/restaurant.dart';
import 'package:submission_2_restaurant_app/data/preferences/preference_helper.dart';
import 'package:submission_2_restaurant_app/providers/favorite_provider.dart';
import 'package:submission_2_restaurant_app/providers/preference_provider.dart';
import 'package:submission_2_restaurant_app/providers/restaurant_provider.dart';
import 'package:submission_2_restaurant_app/providers/scheduling_provider.dart';
import 'package:submission_2_restaurant_app/ui/home_page.dart';
import 'package:submission_2_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:submission_2_restaurant_app/ui/add_review.dart';
import 'package:submission_2_restaurant_app/ui/review_list.dart';
import 'package:submission_2_restaurant_app/ui/search_restaurant.dart';
import 'package:submission_2_restaurant_app/utils/notification_helper.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 final NotificationHelper notificationHelper = NotificationHelper();
 await notificationHelper.initNotification(FlutterLocalNotificationsPlugin());
 notificationHelper.requestPermissionIOS(FlutterLocalNotificationsPlugin());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider()
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider()
        ),
        ChangeNotifierProvider(
          create: (_) => PreferenceProvider(
            preferenceHelper: PreferenceHelper(
              sharedPreferences: SharedPreferences.getInstance()
            )
          )
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(
            favoriteDB: FavoriteDB()
          )
        )
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
      home: const HomePage(),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(id: ModalRoute.of(context)?.settings.arguments as String),
        AddReview.routeName: (context) => AddReview(restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant),
        ReviewList.routeName:(context) => ReviewList(reviews: ModalRoute.of(context)?.settings.arguments),
        SearchRestaurant.routeName: (context) => const SearchRestaurant()
      },
    );
  }
}