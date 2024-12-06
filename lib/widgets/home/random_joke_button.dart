import 'package:flutter/material.dart';

class RandomJokeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RandomJokeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text('Random Jokes'),
      ),
    );
  }
}
