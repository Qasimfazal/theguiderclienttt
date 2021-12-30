import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theguiderclienttt/Meeting.dart';
import 'package:theguiderclienttt/Screens/Madarsa.dart';
import 'package:theguiderclienttt/Screens/SpeechSearch.dart';

class HomeList {
  var destination;
  var image;
  var navigation;

  HomeList({
    @required this.destination,
    @required this.image,
    @required this.navigation,
  });
}

List<HomeList> homelist = [
  HomeList(
    destination: 'Online Madarsa ',
    image: 'assets/OnlineMadarsa.jpeg',
    navigation: OnlineMadarsa(),
  ),
  HomeList(
    destination: 'Full Quran',
    image: 'assets/Quran.jpeg',
    navigation: 'joinmeeting()',
  ),  HomeList(
    destination: 'Audio Quran Search',
    image: 'assets/Quran.jpeg',
    navigation: SpeechSearch(),
  ),
  HomeList(
    destination: 'Quran Audio',
    image: 'assets/tilavat.jpeg',
    navigation: 'jhb',
  ),
  HomeList(
    destination: 'Surah Translation',
    image: 'assets/translation.png',
    navigation: 'jhb',
  ),
  HomeList(
    destination: 'Juzz',
    image: 'assets/juzz.jpeg',
    navigation: 'jhb',
  ),
  HomeList(
    destination: 'Sajda Index',
    image: 'assets/sajda.jpeg',
    navigation: 'jhb',
  ),
  HomeList(
    destination: 'Hadees',
    image: 'assets/hadees.png',
    navigation: 'jhb',
  ),
  HomeList(
    destination: 'Qubla Index',
    image: 'assets/qibla.png',
    navigation: 'jhb',
  ),
  HomeList(
    destination: 'Azan Timming',
    image: 'assets/azan.jpeg',
    navigation: 'jhb',
  ),
];
