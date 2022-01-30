import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theguiderclienttt/Meeting.dart';
import 'package:theguiderclienttt/Screens/AttendanceView.dart';
import 'package:theguiderclienttt/Screens/RegesterCources2.dart';

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
    navigation: Meeting(),
  ),
  OnlineMadarsalist (
    destination: 'Regester Cource',
    image: 'assets/Quran.jpeg',
     navigation: RegesterCourceList(),
  ),
  OnlineMadarsalist (
    destination: 'View Attendance',
    image: 'assets/tilavat.jpeg',
    navigation: Attendanceview(),
  ),


];
