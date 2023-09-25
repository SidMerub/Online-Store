import 'package:flutter/material.dart';

class CustomRatingWidget extends StatelessWidget {
  final String rating;

  CustomRatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    double numericRating = double.parse(rating);

    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < numericRating ? Icons.star : Icons.star_border,
          color: Colors.amber,
        );
      }),
    );
  }
}
