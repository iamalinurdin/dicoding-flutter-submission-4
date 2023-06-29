import 'package:flutter/material.dart';
import 'package:submission_2_restaurant_app/data/commons/state.dart';
import 'package:submission_2_restaurant_app/data/db/favorite_db.dart';
import 'package:submission_2_restaurant_app/data/model/restaurant.dart';

class FavoriteProvider with ChangeNotifier {
  final FavoriteDB favoriteDB;
  late ResultState _state;
  String _message = '';
  List<Restaurant> _favorites = [];

  ResultState get state => _state;
  String get message => _message;
  List<Restaurant> get favorites => _favorites;

  FavoriteProvider({required this.favoriteDB}) {
    _getFavorites();
  }

  void _getFavorites() async {
    _favorites = await favoriteDB.getFavorites();

    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }

    notifyListeners();
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await favoriteDB.getFavoriteById(id);

    return favoriteRestaurant.isNotEmpty;
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await favoriteDB.addFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';

      notifyListeners();
    }
  }

  void removeFavorite(String id) async {
    try {
      await favoriteDB.deleteFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';

      notifyListeners();
    }
  }
}