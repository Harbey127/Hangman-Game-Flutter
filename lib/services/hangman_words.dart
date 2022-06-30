import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

class HangmanWords {
  int wordCounter = 0;
  final List<int> _usedNumbers = [];
  List<String>? _words = ['hello','red', 'go','good', 'strong', 'smart', 'spider', 'man', 'animal', 'cat', 'lion', 'dog', 'run','love', 'caw',];
  
  Future readWords() async{
    //String fileText = await rootBundle.loadString('res/hangman_words.txt');
    _words = ['hello','red', 'go'];
  }

  void restWords(){
    wordCounter =0;
    //_word = [];
  }

  String getWord() {
    wordCounter += 1;
    var rand = Random();
    int wordLength = _words!.length;
    int randNumber = rand.nextInt(wordLength);
    bool notUnique = true;
    if (wordCounter - 1 == _words!.length) {
      notUnique = false;
      return '';
    }
    while (notUnique) {
      if (!_usedNumbers.contains(randNumber)) {
        notUnique = false;
        _usedNumbers.add(randNumber);
        return _words![randNumber];
      } else {
        randNumber = rand.nextInt(wordLength);
      }
    }
    return '';
  }
  // To get numbers characters in text
  String getHiddenWord(int wordLength) {
    String hiddenWord = '';
    for (int i = 0; i < wordLength; i++) {
      hiddenWord += '_';
    }
    return hiddenWord;
  }
}