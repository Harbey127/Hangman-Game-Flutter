import 'package:flutter/material.dart';




class ResultScore extends StatelessWidget {
  final String text;
  const ResultScore({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.only(bottom: 15.0),
       child: Center(
         child: Text(
           text,
           style: Theme.of(context).textTheme.headline2,
         ),
       ),
     );
  }
}
