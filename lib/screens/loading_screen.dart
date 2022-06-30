import 'package:flutter/material.dart';
import 'score_screen.dart';
import '../services/score_db.dart' as score_database;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    queryScores();
  }

  void queryScores() async {
    final database = score_database.openDB();
    var queryResult = await score_database.scores(database);
    print(queryResult);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ScoreScreen(
            query: queryResult,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}