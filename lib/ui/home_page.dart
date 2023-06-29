import 'package:flutter/material.dart';
import 'package:submission_2_restaurant_app/ui/restaurant_detail.dart';
import 'package:submission_2_restaurant_app/ui/restaurant_list_page.dart';
import 'package:submission_2_restaurant_app/ui/search_restaurant.dart';
import 'package:submission_2_restaurant_app/ui/setting_page.dart';
import 'package:submission_2_restaurant_app/utils/notification_helper.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  int selectedPage = 0;

  final List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home'
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.favorite_outline),
    //   label: 'Favorites'
    // ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings'
    ),
  ];



  final List<Widget> pages = [
    const RestaurantListPage(),
    const SettingPage()
  ];

   @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(context, RestaurantDetailPage.routeName);
    _notificationHelper.configureDidReceiveLocalNotificationSubject(context, RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
    didReceiveLocalNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedPage,
            items: bottomNavItems,
            onTap: (index) {
              setState(() {
                selectedPage = index;
              });
            },
          ),
        ),
      ),
      body: pages[selectedPage],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, SearchRestaurant.routeName);
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}