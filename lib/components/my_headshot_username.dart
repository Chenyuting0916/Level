import 'package:flutter/material.dart';

class MyHeadshotAndUsername extends StatelessWidget {
  final String username;
  final String imageUrl;
  const MyHeadshotAndUsername(
      {super.key, required this.username, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              radius: 37,
              backgroundImage: AssetImage(imageUrl),
            ),
          ),
          const SizedBox(
            width: 18,
          ),
          Text(
            username,
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
