import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final dynamic onPressed;
  const CustomButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(1,1),
          ),
        ],
      ),
      child: FittedBox(
        child: TextButton(
          child: Text(text,style: Theme.of(context).textTheme.headline1,),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
