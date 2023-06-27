import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_app/data/model/restaurant.dart';
import 'package:submission_2_restaurant_app/providers/review_provider.dart';

class AddReview extends StatefulWidget {
  static const routeName = '/add_review';
  final Restaurant restaurant;

  const AddReview({super.key, required this.restaurant});
  
  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text('Add Review'),
      ),
      body: ChangeNotifierProvider<ReviewProvider>(
        create: (context) => ReviewProvider(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Consumer<ReviewProvider>(
                builder: (context, state, _) {
                  if (state.state == ReviewState.loading) {
                    return const Center(
                      child: CircularProgressIndicator()
                    );
                  } else if (state.state == ReviewState.success) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Your review has been added. Thank you.'),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            }, 
                            child: const Text('Back')
                          )
                        ],
                      ),
                    );
                  } else if (state.state == ReviewState.failed) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Oops, your review failed to added. Please try again later.'),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            }, 
                            child: const Text('Back')
                          )
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your review is useful for ${widget.restaurant.name}, give the best review.',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Your name',
                            labelStyle: const TextStyle(
                              color: Colors.white
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(23, 74, 98, 163),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _reviewController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Review',
                            labelStyle: const TextStyle(
                              color: Colors.white
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(23, 74, 98, 163),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final payload = {
                                'id': widget.restaurant.id,
                                'name': _nameController.text,
                                'review': _reviewController.text
                              };
                        
                              Provider.of<ReviewProvider>(context, listen: false).addReview(payload);
                            },
                            child: const Text('Save Review'),
                          )
                        )
                      ],
                    );
                  }

                } 

              ),
            ),
          ),
        ),
      )
    );
  }
}