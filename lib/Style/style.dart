import 'dart:ui';
import 'package:flutter/material.dart';

const colorRed = Color.fromRGBO(231, 28, 36, 1);
const colorDark = Color.fromRGBO(136, 28, 32, 1);
const colorGreen=Color.fromRGBO(33, 191, 115, 1);
const colorBlue=Color.fromRGBO(52, 152, 219,1.0);
const colorOrange=Color.fromRGBO(230, 126, 34,1.0);
const colorWhite=Color.fromRGBO(255, 255, 255,1.0);
const colorDarkBlue=Color.fromRGBO(44, 62, 80,1.0);
const colorLightGray=Color.fromRGBO(135, 142, 150, 1.0);
const colorLight=Color.fromRGBO(211, 211, 211, 1.0);

TextStyle headlineForm (textColor){
  return TextStyle(
    fontSize: 32,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w600,
    color: textColor,
  );
}
TextStyle forgotPassword (textColor){
  return TextStyle(
    fontSize: 16,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w400,
    color: textColor,
  );
}
TextStyle formBottom (textColor){
  return TextStyle(
    fontSize: 18,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w200,
    color: textColor,
  );
}
TextStyle signUp (textColor){
  return TextStyle(
    fontSize: 20,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w600,
    color: textColor,
  );
}

