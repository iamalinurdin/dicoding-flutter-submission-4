import 'package:flutter/material.dart';
import 'package:submission_2_restaurant_app/data/api/api_service.dart';
import 'package:submission_2_restaurant_app/data/model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider with ChangeNotifier {
  late ApiService apiService = ApiService();
  dynamic _restaurantResult;
  late Restaurant _restaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  ResultState get state => _state;
  dynamic get result => _restaurantResult;
  Restaurant get restaurant => _restaurant;

  RestaurantProvider() {
    _state = ResultState.noData;
    notifyListeners();
  }

  Future<dynamic> fetchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await apiService.getRestaurants();

      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'no data is found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();

      return _message = 'Error: $e';
    }
  }

  Future<dynamic> fetchDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await apiService.detailRestaurant(id);

      _state = ResultState.hasData;
      notifyListeners();

      _restaurant = response;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();

      return _message = 'Error: $e';
    }
  }

  Future<dynamic> searchRestaurant(String query) async {
    try {
      if (query == '') {
        _state = ResultState.noData;
        notifyListeners();
        return _message = '';
      }

      _state = ResultState.loading;
      notifyListeners();
      
      final response = await apiService.searchRestaurant(query);

      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'no data is found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();

        return _restaurantResult = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();

      return _message = 'Error: $e';
    }
  }
}