import 'package:flutter/material.dart';
import 'package:hangman_game/screens/loading_screen.dart';
import 'package:hangman_game/screens/score_screen.dart';

import '../services/hangman_words.dart';
import '../widgets/custom_button.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {

   const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HangmanWords hangmanWords = HangmanWords();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FittedBox(
                child: Text(
                  'HANGMAN',
                  style: theme.textTheme.headline1,
                ),
              ),

              Image.asset('assets/gallow.png'),
              CustomButton(
                text: 'Start',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GameScreen()));
                },
              ),
              CustomButton(
                text: 'High Scores',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoadingScreen()));
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
