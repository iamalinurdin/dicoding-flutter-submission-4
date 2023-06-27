import 'package:flutter/material.dart';
import 'package:submission_2_restaurant_app/data/api/api_service.dart';

enum ReviewState {
  loading, 
  success, 
  failed,
  none
}

class ReviewProvider with ChangeNotifier {
  late ApiService apiService = ApiService();
  late ReviewState _state;
  String _message = '';

  ReviewProvider() {
    _state = ReviewState.none;
  }

  String get message => _message;
  ReviewState get state => _state;

  Future<dynamic> addReview(payload) async {
    try {
      _state = ReviewState.loading;
      notifyListeners();

      final response = await apiService.addReview(payload);

      if (response['error'] == false) {
        _state = ReviewState.success;
        notifyListeners();
        return _message = 'success';
      }
      
    } catch (e) {
      _state = ReviewState.failed;
      notifyListeners();

      return _message = 'Error: $e';
    }

  }
}