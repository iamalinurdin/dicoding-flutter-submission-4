import 'package:flutter/material.dart';

class ItemMenu extends StatelessWidget {
  final String menu;
  final String image;

  const ItemMenu({
    super.key, 
    required this.menu,
    required this.image,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {}, 
                  icon: const Icon(Icons.favorite_outline),
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Text(
            menu,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
            ),
          ),
        ],
      )
    );
  }
}