import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theguiderclienttt/List/MAdarsaList/MyCourceList.dart';
import 'package:theguiderclienttt/Meeting.dart';
import 'package:theguiderclienttt/Screens/Mycourcelist.dart';

class OnlineMadarsalist {
  var destination;
  var image;
  var navigation;

  OnlineMadarsalist ({
    @required this.destination,
    @required this.image,
    @required this.navigation,
  });
}

List<OnlineMadarsalist > madarsaList = [
  OnlineMadarsalist (
    destination: 'My Cources ',
    image: 'assets/OnlineMadarsa.jpeg',
    navigation: courceList(),
  ),
  OnlineMadarsalist (
    destination: 'Regester Cource',
    image: 'assets/Quran.jpeg',
     navigation: 'joinmeeting()',
  ),
  OnlineMadarsalist (
    destination: 'Attendance',
    image: 'assets/tilavat.jpeg',
    navigation: 'jhb',
  ),


];
