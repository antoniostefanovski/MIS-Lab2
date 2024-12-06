import 'package:flutter/material.dart';
import 'package:lab2_mis/services/api_services.dart';
import 'dart:convert';

import '../models/joke.dart';
import '../widgets/back_home_btn.dart';
import '../widgets/jokes/JokeCard.dart';

class JokeDetails extends StatefulWidget {
  final String jokeType;

  const JokeDetails({super.key, required this.jokeType});

  @override
  State<JokeDetails> createState() => _JokeState();
}

class _JokeState extends State<JokeDetails> {
  late Future<List<Joke>> jokes;

  @override
  void initState() {
    super.initState();
    jokes = getJokeWithType(widget.jokeType);
  }

  Future<List<Joke>> getJokeWithType(String type) async {
    var response = await ApiService.getJokeWithType(type);
    var data = json.decode(response.body);
    return data.map<Joke>((joke) => Joke(id: joke['id'],
                                        type: joke['type'],
                                        setup: joke['setup'],
                                        punchline: joke['punchline'])).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.jokeType} Jokes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Joke>>(
              future: jokes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final jokesList = snapshot.data!;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: jokesList.length,
                      itemBuilder: (context, index) {
                        return JokeCard(joke: jokesList[index]);
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('No joke available'));
                }
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: BackHomeBtn()
          ),
        ],
      ),
    );
  }


}
