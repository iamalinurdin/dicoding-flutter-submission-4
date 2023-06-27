class RestaurantResult {
  final String message;
  final int total;
  final List<Restaurant> restaurants;

  RestaurantResult({
    required this.message, 
    required this.total, 
    required this.restaurants
  });

  factory RestaurantResult.fromJson(Map<String, dynamic> json) => RestaurantResult(
    message    : json['message'], 
    total      : json['count'], 
    restaurants: List<Restaurant>.from(
      (json['restaurants'] as List)
        .map(
          (item) => Restaurant.fromJson(item)
        )
      )
  );
}

class RestaurantSearch {
  final int total;
  final List<Restaurant> restaurants;

  RestaurantSearch({
    required this.total, 
    required this.restaurants
  });

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) => RestaurantSearch(
    total      : json['founded'], 
    restaurants: List<Restaurant>.from(
      (json['restaurants'] as List)
        .map(
          (item) => Restaurant.fromJson(item)
        )
      )
  );
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating ;
  final dynamic menus;
  final dynamic reviews;
  final dynamic categories;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
    required this.reviews,
    required this.categories,
  });

  factory Restaurant.fromJson(Map<dynamic, dynamic> item) {
    return Restaurant(
      id         : item['id'],
      name       : item['name'],
      description: item['description'],
      pictureId  : 'https://restaurant-api.dicoding.dev/images/medium/${item['pictureId']}',
      city       : item['city'],
      rating     : item['rating'],
      menus      : item['menus'],
      reviews    : item['customerReviews'],
      categories : item['categories'] != null ? (item['categories'] as List).map((item) => item['name']).toList().join(', ') : item['categories'],
    );
  }
  
}