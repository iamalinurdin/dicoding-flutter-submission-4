// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:submission_2_restaurant_app/main.dart';
import 'package:submission_2_restaurant_app/providers/restaurant_provider.dart';
import 'package:submission_2_restaurant_app/ui/restaurant_list_page.dart';

Widget restaurantList() => ChangeNotifierProvider<RestaurantProvider>(
  create: (context) => RestaurantProvider()..fetchRestaurant(),
  child: const MaterialApp(
    home: RestaurantListPage(),
  ),
);

void main() {
  testWidgets('show list of restaurants', (WidgetTester tester) async {
    await tester.pumpWidget(restaurantList());

    expect(find.byType(Text), findsWidgets);
  });
}
