import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:submission_2_restaurant_app/data/model/restaurant.dart';

class ApiService {
  final String baseURL = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantResult>getRestaurants() async {
    final response = await http.get(Uri.parse('$baseURL/list'));

    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch top headlines');
    }
  }

  Future<Restaurant> detailRestaurant(id) async {
    final response = await http.get(Uri.parse('$baseURL/detail/$id'));

    if (response.statusCode == 200) {
      return Restaurant.fromJson(json.decode(response.body)['restaurant']);
    } else {
      throw Exception('Failed to fetch detail restaurant');
    }
  }

  Future<RestaurantSearch> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse('$baseURL/search?q=$query'));

    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch search restaurant');
    }
  }

  Future<dynamic> addReview(payload) async {
    final response = await http.post(Uri.parse('$baseURL/review'), body: payload);

    // print(json.decode(response.body)['message']);
    // print(response.statusCode);

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to store review');
    }
  }
}