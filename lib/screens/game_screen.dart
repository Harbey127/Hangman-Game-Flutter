import 'package:flutter/material.dart';
import '/screens/home_screen.dart';
import '../services/alphabet.dart';

import '../services/constants.dart';
import '../services/hangman_words.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:math';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../services/score_db.dart' as score_database;
import '../services/user_scores.dart';

class GameScreen extends StatefulWidget {
  final HangmanWords hangmanObject = HangmanWords();
    GameScreen({Key? key }) : super(key: key);



  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final database = score_database.openDB();
  int lives = 5;
  Alphabet englishAlphabet = Alphabet();
  String? word;
  String? hiddenWord;
  List<String> wordList = [];
  List<int> hintLetters = [];
  List<bool>? buttonStatus;
  bool? hintStatus;
  int hangState = 0;
  int wordCount = 0;
  bool finishedGame = false;
  bool resetGame = false;

  void newGame() {
    setState(() {
      widget.hangmanObject.restWords();
      englishAlphabet = Alphabet();
      lives = 5;
      wordCount = 0;
      finishedGame = false;
      resetGame = false;
      initWords();
    });
  }

  Widget createButton(index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 6.0),
      alignment: Alignment.center,
      child: Center(
        child: MaterialButton(
          color: Colors.blue,
          child: Text(englishAlphabet.alphabet[index].toUpperCase(),style: Theme.of(context).textTheme.headline3,),
          onPressed: buttonStatus![index] ? () => wordPress(index) : null,
        ),
      ),
    );
  }



  void initWords() {
    finishedGame = false;
    resetGame = false;
    hintStatus = true;
    hangState = 0;
    buttonStatus = List.generate(26, (index) {
      return true;
    });
    wordList = [];
    hintLetters = [];
    word = widget.hangmanObject.getWord();
//    print
    print('this is word ' + word!);
    print('\nthis is score $wordCount');
    if (word!.isNotEmpty) {
      hiddenWord = widget.hangmanObject.getHiddenWord(word!.length);
    } else {
      Score score = Score(
          id: 1,
          scoreDate: DateTime.now().toString(),
          userScore: wordCount);
      score_database.manipulateDatabase(score, database);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),

      );
    }

    for (int i = 0; i < word!.length; i++) {
      wordList.add(word![i]);
      hintLetters.add(i);
    }
  }

  void wordPress(int index) {
    if (lives == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),

      );
    }

    if (finishedGame) {
      setState(() {
        resetGame = true;
      });
      return;
    }

    bool check = false;
    setState(() {
      for (int i = 0; i < wordList.length; i++) {
        if (wordList[i] == englishAlphabet.alphabet[index]) {
          check = true;
          wordList[i] = '';
          hiddenWord = hiddenWord!.replaceFirst(RegExp('_'), word![i], i);
        }
      }
      for (int i = 0; i < wordList.length; i++) {
        if (wordList[i] == '') {
          hintLetters.remove(i);
        }
      }
      if (!check) {
        hangState += 1;
      }

      if (hangState == 6) {
        finishedGame = true;
        lives --;
        if (lives <= 1) {
          if (wordCount > 0) {
            Score score = Score(
                id: 1,
                scoreDate: DateTime.now().toString(),
                userScore: wordCount);
            score_database.manipulateDatabase(score, database);
          }
          Alert(
              style: kGameOverAlertStyle,
              context: context,
              title: "Game Over!",
              desc: "Your score is $wordCount",
              buttons: [
                DialogButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),

                  ),
                  child: const Icon(
                    MdiIcons.home,
                    size: 30.0,
                  ),

                  color: kDialogButtonColor,

                ),
                DialogButton(

                  onPressed: () {
                    newGame();
                    Navigator.pop(context);
                  },
                  child: const Icon(MdiIcons.refresh, size: 30.0),

                  color: kDialogButtonColor,

                ),
              ]).show();
        } else {
          Alert(
            context: context,
            style: kFailedAlertStyle,
            type: AlertType.error,
            title: word,
            buttons: [
              DialogButton(
                radius: BorderRadius.circular(10),
                child: const Icon(
                  MdiIcons.arrowRightThick,
                  size: 30.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    initWords();
                  });
                },
                width: 127,
                color: kDialogButtonColor,
                height: 52,
              ),
            ],
          ).show();
        }
      }

      buttonStatus![index] = false;
      if (hiddenWord == word) {
        finishedGame = true;
        Alert(
          context: context,
          style: kSuccessAlertStyle,
          type: AlertType.success,
          title: word,
//          desc: "You guessed it right!",
          buttons: [
            DialogButton(
              radius: BorderRadius.circular(10),
              child: const Icon(
                MdiIcons.arrowRightThick,
                size: 30.0,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  wordCount += 1;
                  Navigator.pop(context);
                  initWords();
                });
              },
              width: 127,
              color: kDialogButtonColor,
              height: 52,
            )
          ],
        ).show();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initWords();
  }

  @override
  Widget build(BuildContext context) {
    if (resetGame) {
      setState(() {
        initWords();
      });
    }
    final theme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      //padding: const EdgeInsets.only(top: 0.5),
                                      child: const Icon(
                                        MdiIcons.heart,
                                        color: Colors.red,
                                        size: 39,
                                      ),
                                    ),
                                    Container(
                                      //alignment: Alignment.center,
                                      child: SizedBox(
                                        // height: 38,
                                        // width: 38,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              lives.toString() == "1"
                                                  ? "I"
                                                  : lives.toString(),
                                              style: Theme.of(context).textTheme.headline2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              wordCount == 1 ? "I" : '$wordCount',
                              style: kWordCounterTextStyle,
                            ),
                            IconButton(

                              iconSize: 39,
                              icon: const Icon(MdiIcons.lightbulb, color: Colors.yellow),
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: hintStatus!
                                  ? () {
                                int rand = Random()
                                    .nextInt(hintLetters.length);
                                wordPress(englishAlphabet.alphabet
                                    .indexOf(
                                    wordList[hintLetters[rand]]));
                                hintStatus = false;
                              }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: FittedBox(
                            child: Image.asset(
                              'assets/$hangState.png',
                              height: 1001,
                              width: 991,
                              gaplessPlayback: true,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 35.0),
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              hiddenWord!,
                              style: theme.headlineLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(10.0, 2.0, 8.0, 10.0),
                alignment: Alignment.center,
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,

                  //columnWidths: {1: FlexColumnWidth(10)},
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: createButton(0),
                      ),
                      TableCell(
                        child: createButton(1),
                      ),
                      TableCell(
                        child: createButton(2),
                      ),
                      TableCell(
                        child: createButton(3),
                      ),
                      TableCell(
                        child: createButton(4),
                      ),
                      TableCell(
                        child: createButton(5),
                      ),
                      TableCell(
                        child: createButton(6),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: createButton(7),
                      ),
                      TableCell(
                        child: createButton(8),
                      ),
                      TableCell(
                        child: createButton(9),
                      ),
                      TableCell(
                        child: createButton(10),
                      ),
                      TableCell(
                        child: createButton(11),
                      ),
                      TableCell(
                        child: createButton(12),
                      ),
                      TableCell(
                        child: createButton(13),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: createButton(14),
                      ),
                      TableCell(
                        child: createButton(15),
                      ),
                      TableCell(
                        child: createButton(16),
                      ),
                      TableCell(
                        child: createButton(17),
                      ),
                      TableCell(
                        child: createButton(18),
                      ),
                      TableCell(
                        child: createButton(19),
                      ),
                      TableCell(
                        child: createButton(20),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: createButton(21),
                      ),
                      TableCell(
                        child: createButton(22),
                      ),
                      TableCell(
                        child: createButton(23),
                      ),
                      TableCell(
                        child: createButton(24),
                      ),
                      TableCell(
                        child: createButton(25),
                      ),
                      const TableCell(
                        child: Text(''),
                      ),
                      const TableCell(
                        child: Text(''),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}