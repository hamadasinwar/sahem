import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  final String imagePath;

  const SearchItem({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 4), // Shadow position
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          child: Image.network(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
