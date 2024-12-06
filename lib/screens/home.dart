import 'package:flutter/material.dart';
import 'package:lab2_mis/screens/random_joke.dart';
import 'dart:convert';

import '../services/api_services.dart';
import '../widgets/home/joke_types_card.dart';
import '../widgets/home/random_joke_button.dart';
import 'joke.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  List<String> jokeTypes = [];

  @override
  void initState() {
    super.initState();
    getJokeTypes();
  }

  void getJokeTypes() async {
    ApiService.getJokeTypes().then((response) {
      var data = json.decode(response.body);
      setState(() {
        jokeTypes = List<String>.from(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('211137 - Jokes'),
      ),
      body: jokeTypes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          RandomJokeButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RandomJoke(),
                ),
              );
            },
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: jokeTypes.length,
              itemBuilder: (context, index) {
                return JokeTypesCard(
                  jokeType: jokeTypes[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JokeDetails(
                          jokeType: jokeTypes[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
