import 'package:flutter/material.dart';
import 'package:lab2_mis/screens/home.dart';
import 'package:lab2_mis/screens/joke.dart';
import 'package:lab2_mis/screens/random_joke.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon',
      initialRoute: '/',
      routes: {
        '/' : (context) => const Home(),
        '/random_joke' : (context) => const RandomJoke(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/joke_details') {
          final String jokeType = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => JokeDetails(jokeType: jokeType),
          );
        }
        return null;
      },
    );
  }

}
