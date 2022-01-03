import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:theguiderclienttt/model/Cource_Shedule_Model.dart';
import 'package:theguiderclienttt/model/Mycoursesmodel.dart';
import 'package:theguiderclienttt/model/Regester_Cources.dart';
import 'package:theguiderclienttt/model/StudentAttendance.dart';

String Student_Name;
List<Regester_Cources_Model> Regestercource =
    new List<Regester_Cources_Model>();
List<String> Allteachers_Uid = new List<String>();
List<String> course_uid = new List<String>();
List<bool> statelist = new List<bool>();
List<String> Allteachers_Cource_Detail = new List<String>();
List<Cource_Shedule_Model> Allteachers_Declared_variables =
    new List<Cource_Shedule_Model>();
List<MyCoursesModel> myCoursesList = [];
List<String> Student_CourceList = [];

String TRANASfer_Room_Id;
String TRANASfer_Slot_time;
String TRANASfer_Slot_No;
String TRANASfer_Absence;
String TRANASfer_Cource_Name;
String cid;

String tid;


  Future<void> Retrive_all_teachers_Classes() async {
    Allteachers_Uid.clear();
    Allteachers_Cource_Detail.clear();
    Regestercource.clear();
    DatabaseReference DB_Refrance =
        await FirebaseDatabase.instance.reference().child("courseSchedule");
    DB_Refrance.once().then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> value = dataSnapshot.value;
      Iterable childkey1 = value.keys;
      childkey1.forEach((element) {
        Allteachers_Uid.add(element);
      });
    }).then((value) async {
      await fetchCourseDetails();
    });
  }

  fetchCourseDetails() async {
    for (int i = 0; i < Allteachers_Uid.length; i++) {
      DatabaseReference DB_Refrance1 = await FirebaseDatabase.instance
          .reference()
          .child("courseSchedule")
          .child(Allteachers_Uid.elementAt(i));
      DB_Refrance1.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> value = snapshot.value;
        Iterable childkey2 = value.keys;
        childkey2.forEach((element) {
          Allteachers_Cource_Detail.add(element);
        });
      }).then((value) async {
        await fetchCourseFurtherDetails();
      });
    }
  }

  fetchCourseFurtherDetails() async {
    for (int i = 0; i < Allteachers_Uid.length; i++) {
      for (int k = 0; k < Allteachers_Cource_Detail.length; k++) {
        DatabaseReference DB_Refrance2 = await FirebaseDatabase.instance
            .reference()
            .child("courseSchedule")
            .child(Allteachers_Uid.elementAt(i))
            .child(Allteachers_Cource_Detail.elementAt(k));
        DB_Refrance2.once().then((DataSnapshot dataSnapshot1) {
          String _cuid = dataSnapshot1.key;
          String _day = dataSnapshot1.value["Day"];
          String _name = dataSnapshot1.value["Courcename"];
          String _roomId = dataSnapshot1.value["RoomID"];
          String _slotno = dataSnapshot1.value["SlotNo"];
          String _slottime = dataSnapshot1.value["SlotTime"];
          String _strength = dataSnapshot1.value["StudentStrength"];
          String _tuid = dataSnapshot1.value["Teacher_Uid"];
          DatabaseReference DB_Refrance3 = FirebaseDatabase.instance
              .reference()
              .child("UserTeacher")
              .child(_tuid);
          DB_Refrance3.once().then((DataSnapshot dataSnapshot3) {
            String _teachername = dataSnapshot3.value["Name"];
            Regester_Cources_Model aa = new Regester_Cources_Model(
                _cuid,
                _name,
                _day,
                _roomId,
                _slotno,
                _slottime,
                _strength,
                _tuid,
                _teachername,
                _tuid);
            Regestercource.add(aa);
          });
        });
      }
    }
  }
class DataR {
  static Future<String> RetrieveData() {
    FirebaseAuth auth = FirebaseAuth.instance;
    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("UserClient")
        .child(auth.currentUser.uid);
    reference.once().then((DataSnapshot snapshot) {
      Student_Name = snapshot.value["Name"];
    });
  }
}
