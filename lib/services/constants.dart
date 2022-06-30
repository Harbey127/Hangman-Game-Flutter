import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


ThemeData dark = ThemeData(
  appBarTheme:  AppBarTheme(
    iconTheme:  const IconThemeData(color: Colors.white),
    backgroundColor: Colors.black.withOpacity(0.0),
    elevation: 0.0,
  ),
  scaffoldBackgroundColor: Colors.white.withOpacity(0.1),
  backgroundColor: Colors.white.withOpacity(0.1),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
        fontSize: 57,
        color: Colors.white,
        fontFamily: 'FiraMono-Bold',
        letterSpacing: 8,
    ),
    headline1: TextStyle(
      fontSize: 45.0,
      fontWeight: FontWeight.w900,
      fontFamily: 'PatrickHand-Regular',
      color: Colors.white,
    ),
    headline2: TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 1.0,
    ),
    headline3: TextStyle(
      color: Colors.white,
      fontSize: 25.0,
      letterSpacing: 1.0,
      fontFamily: 'FiraMono-Bold',
    ),
    headline4: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w900,
      fontFamily: 'PatrickHand-Regular',
      color: Colors.white,
    ),
    headline6: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w900,
      fontFamily: 'PatrickHand-Regular',
      color: Colors.black,
    ),
  ),
);





var kSuccessAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: const Duration(milliseconds: 500),
  backgroundColor: const Color(0xFF2C1E68),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  titleStyle: const TextStyle(
    color: Color(0xFF00e676),
    fontWeight: FontWeight.bold,
    fontSize: 30.0,
    letterSpacing: 1.5,
  ),
);
var kExitAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 27.0,
    letterSpacing: 2.0,
  ),
  animationDuration: const Duration(milliseconds: 500),
  backgroundColor: const Color(0xFF2C1E68),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  titleStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 27.0,
    letterSpacing: 2.0,
  ),
);

var kGameOverAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: const Duration(milliseconds: 450),
  backgroundColor: const Color(0xFF2C1E68),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  titleStyle: const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 30.0,
    letterSpacing: 1.5,
  ),
  descStyle: const TextStyle(
    color: Colors.lightBlue,
    fontWeight: FontWeight.bold,
    fontSize: 25.0,
    letterSpacing: 1.5,
  ),
);

var kFailedAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: const Duration(milliseconds: 450),
  backgroundColor: const Color(0xFF2C1E68),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  titleStyle: const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 30.0,
    letterSpacing: 1.5,
  ),
);

const kDialogButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 25,
  fontWeight: FontWeight.w300,
  letterSpacing: 0.5,
);



const kDialogButtonColor = Color(0x00000000);

const kWordCounterTextStyle =
TextStyle(fontSize: 29.5, color: Colors.white, fontWeight: FontWeight.w900);