import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:theguiderclienttt/Config.dart';
import 'package:theguiderclienttt/Screens/HomeScreen.dart';
import 'package:theguiderclienttt/globals.dart';
import 'package:theguiderclienttt/model/Student_Regesterd_Model.dart';
import 'package:theguiderclienttt/widget/FadedAnimation.dart';

class RegesterCourceList extends StatefulWidget {
  // const courceList({Key key}) : super(key: key);

  @override
  _RegesterCourceListState createState() => _RegesterCourceListState();
}

class _RegesterCourceListState extends State<RegesterCourceList> {
  @override
  FirebaseAuth auth = FirebaseAuth.instance;

  String R_Teacher_Name,
      R_Cource_Name,
      R_Slot_Time,
      R_Day,
      R_Student_Strength,
      R_Room_ID,
      R_TUID,
      R_CID;
  List<String> student_course_uidlist = new List<String>();
  List<Student_Regester_Cources_Model> student_register_cource_list =
  new List<Student_Regester_Cources_Model>();
  List<bool> statelist = new List<bool>();

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void Retrive_all_student_Classes() {
    FirebaseAuth auth = FirebaseAuth.instance;
    DatabaseReference DB_Refrance = FirebaseDatabase.instance
        .reference()
        .child("StudentCourse")
        .child(auth.currentUser.uid);
    DB_Refrance.once().then((DataSnapshot snapshot) {
      student_course_uidlist.clear();
      student_register_cource_list.clear();
      if (!snapshot.exists) {
        checkCoursesStrength(R_TUID, R_CID);
      } else {
        Map<dynamic, dynamic> value = snapshot.value;
        Iterable childkey1 = value.keys;
        childkey1.forEach((element) {
          student_course_uidlist.add(element);
        });
        for (int res = 0; res < student_course_uidlist.length; res++) {
          DatabaseReference DB_Reference1 = FirebaseDatabase.instance
              .reference()
              .child("StudentCourse")
              .child(auth.currentUser.uid)
              .child(student_course_uidlist.elementAt(res));
          DB_Reference1.once().then((DataSnapshot snapshot) {
            String cid = snapshot.key;
            String Courcename = snapshot.value["Courcename"];
            String Day = snapshot.value["Day"];
            String RoomID = snapshot.value["RoomID"];
            String SlotTime = snapshot.value["SlotTime"];
            String SlotNo = snapshot.value["SlotNo"];
            String Student_Strength = snapshot.value["StudentStrength"];
            String Teacher_Uid = snapshot.value["Teacher_Uid"];
            Student_Regester_Cources_Model srcm =
            new Student_Regester_Cources_Model(cid, Courcename, Day, RoomID,
                SlotNo, SlotTime, Student_Strength, Teacher_Uid);
            student_register_cource_list.add(srcm);
          });
        }
        Future.delayed(Duration(seconds: 5), () {
          for (int res = 0; res < student_register_cource_list.length; res++) {
            String select_days = R_Day;
            String slot_time = R_Slot_Time;
            if (student_register_cource_list.elementAt(res).SlotTime ==
                slot_time &&
                student_register_cource_list.elementAt(res).Day ==
                    select_days) {

              statelist.add(true);
            } else {
              statelist.add(false);
            }
          }
        });
        Future.delayed(Duration(seconds: 5), () {
          if (statelist.contains(true)) {
            Fluttertoast.showToast(
                msg: 'Clash in Class',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            statelist = new List<bool>();
            student_course_uidlist = new List<String>();

            student_register_cource_list =
            new List<Student_Regester_Cources_Model>();
          } else {
            checkCoursesStrength(R_TUID, R_CID);
            statelist = new List<bool>();
            student_course_uidlist = new List<String>();
            student_register_cource_list =
            new List<Student_Regester_Cources_Model>();
          }
        });
      }
    });
  }

  Widget ListDesign() {
    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: Regestercource.length,
      itemBuilder: (BuildContext ctx, index) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: <Widget>[
              FadeAnimation(
                  1.8,
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                          EdgeInsets.only(left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                'Teacher Name: ',
                                style: TextColour,
                              ),
                              Spacer(),
                              Text(
                                R_Teacher_Name =
                                    Regestercource[index].Teacher_Name,
                                style: TextColour,
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 5),
                          child: Divider(
                            height: 9,
                            thickness: 1.0,
                          ),
                        ),
                        Container(
                          padding:
                          EdgeInsets.only(left: 15, right: 15, top: 10),
                          child: Row(
                            children: [
                              Text(
                                'Cource Name: ',
                                style: TextColour,
                              ),
                              Spacer(),
                              Text(
                                R_Cource_Name =
                                    Regestercource[index].Courcename,
                                style: TextColour,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 5),
                          child: Divider(
                            height: 9,
                            thickness: 1.0,
                          ),
                        ),
                        Container(
                          padding:
                          EdgeInsets.only(left: 15, right: 15, top: 10),
                          child: Row(
                            children: [
                              Text(
                                'Slot Time : ',
                                style: TextColour,
                              ),
                              Spacer(),
                              Text(
                                R_Slot_Time = Regestercource[index].SlotTime,
                                style: TextColour,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 5),
                          child: Divider(
                            height: 9,
                            thickness: 1.0,
                          ),
                        ),
                        Container(
                          padding:
                          EdgeInsets.only(left: 15, right: 15, top: 10),
                          child: Row(
                            children: [
                              Text(
                                'Day : ',
                                style: TextColour,
                              ),
                              Spacer(),
                              Text(
                                R_Day = Regestercource[index].Day,
                                style: TextColour,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 5),
                          child: Divider(
                            height: 9,
                            thickness: 1.0,
                          ),
                        ),
                        Container(
                          padding:
                          EdgeInsets.only(left: 15, right: 15, top: 10),
                          child: Row(
                            children: [
                              Text(
                                'Student Strength : ',
                                style: TextColour,
                              ),
                              Spacer(),
                              Text(
                                R_Student_Strength =
                                    Regestercource[index].Student_Strength,
                                style: TextColour,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 5),
                          child: Divider(
                            height: 9,
                            thickness: 1.0,
                          ),
                        ),
                        Container(
                          padding:
                          EdgeInsets.only(left: 15, right: 15, top: 10),
                          child: Row(
                            children: [
                              Text(
                                'Room ID : ',
                                style: TextColour,
                              ),
                              Spacer(),
                              Text(
                                R_Room_ID = Regestercource[index].RoomID,
                                style: TextColour,
                              ),
                            ],
                          ),
                        ),
                        // Divider(
                        //   height: 48.0,
                        //   thickness: 2.0,
                        // ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              FadeAnimation(
                  2,
                  InkWell(
                    onTap: () {
                      R_TUID = Regestercource[index].Teacheruid;
                      R_CID = Regestercource[index].id;
                      Retrive_all_student_Classes();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6),
                          ])),
                      child: Center(
                        child: Text(
                          "Regester ",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/background.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeAnimation(
                          1,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/light-1.png'))),
                          )),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(
                          1.3,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/light-2.png'))),
                          )),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(
                          1.5,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/clock.png'))),
                          )),
                    ),
                    Positioned(
                      top: 40,
                      left: 30,
                      child: FadeAnimation(
                          1.6,
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Center(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {

                                      myCoursesList.clear();
                                      Student_CourceList.clear();
                                     Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                  Text(
                                    "Regester Cources",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 1.35,
                  child: ListDesign()),
            ],
          ),
        ),
      ),
    );
  }

  void inputData() {
    String slotno = "";
    if (R_Slot_Time == "8:00") {
      slotno = "1";
    } else if (R_Slot_Time == "9:00") {
      slotno = "2";
    } else if (R_Slot_Time == "10:00") {
      slotno = "3";
    } else if (R_Slot_Time == "11:00") {
      slotno = "4";
    } else if (R_Slot_Time == "12:00") {
      slotno = "5";
    }

    DatabaseReference reff = FirebaseDatabase.instance
        .reference()
        .child("StudentCourse")
        .child(auth.currentUser.uid);
    reff.child(R_CID).set({
      'StudentName':Student_Name,
      'RoomID': R_Room_ID,
      'Courcename': R_Cource_Name,
      'Teacher_Uid': R_TUID,
      'SlotNo': slotno,
      'SlotTime': R_Slot_Time,
      'Absents': "0",
      'Day': R_Day,
      'Present':'0',
      'StudentStrength': R_Student_Strength,
    }).whenComplete(() {
      Fluttertoast.showToast(
          msg: 'Sucessfully Created',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      myCoursesList.clear();
      Student_CourceList.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  void checkCoursesStrength(String tid, String cid) {
    DatabaseReference reff = FirebaseDatabase.instance
        .reference()
        .child("courseSchedule")
        .child(tid)
        .child(cid);
    reff.once().then((DataSnapshot snapshot) {
      String cst = snapshot.value["StudentStrength"];
      int cstval = int.parse(cst);
      if (cstval != 0) {
        cstval = cstval - 1;
        Map<String, Object> createDoc = new HashMap();
        createDoc['StudentStrength'] = cstval.toString();
        reff.update(createDoc).whenComplete(() {

          inputData();
        });

      }else{
        Fluttertoast.showToast(
            msg: 'Class Limit reached',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }
}