import 'package:flutter/material.dart';

class ReviewList extends StatelessWidget {
  static const routeName = '/review_list';
  final dynamic reviews;

  const ReviewList({
    super.key,
    required this.reviews
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text('Reviews'),
        actions: [
          TextButton(
            onPressed: () {}, 
            child: const Text('Add Review')
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    reviews[index]['review'],
                    style: const TextStyle(
                      fontSize: 18
                    ),
                  ),
                  subtitle: Text(
                    reviews[index]['name'],
                    style: const TextStyle(
                      color: Colors.white
                    ),
                  ),
                  trailing: Text(reviews[index]['date']),
                );
              }
            ),
          ),
        )
      ),
    );
  }
}