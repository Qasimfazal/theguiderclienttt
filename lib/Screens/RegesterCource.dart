import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:theguiderclienttt/Config.dart';
import 'package:theguiderclienttt/List/MAdarsaList/MyCourceList.dart';
import 'package:theguiderclienttt/globals.dart';
import 'package:theguiderclienttt/model/Cource_Shedule_Model.dart';
import 'package:theguiderclienttt/model/Regester_Cources.dart';
import 'package:theguiderclienttt/model/Std_Regestered_Cource.dart';
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
  List<Regester_Cources_Model> Regestercource = new List<Regester_Cources_Model>();
  List<String> Allteachers_Uid = new List<String>();
  List<String> course_uid = new List<String>();
  List<bool> statelist = new List<bool>();
  List<String> Allteachers_Cource_Detail = new List<String>();
  List<Cource_Shedule_Model> Allteachers_Declared_variables = new List<Cource_Shedule_Model>();
  void Retrive_all_teachers_Classes() {
    FirebaseAuth auth = FirebaseAuth.instance;
    DatabaseReference DB_Refrance = FirebaseDatabase.instance.reference().child("courseSchedule");
    DB_Refrance.once().then((DataSnapshot snapshot) {
      String keys = snapshot.key;
      Map<dynamic, dynamic> value = snapshot.value;
      Iterable childkey1 = value.keys;
      childkey1.forEach((element) {
        Allteachers_Uid.add(element);
        for (int i = 0; i < Allteachers_Uid.length; i++) {
          DatabaseReference DB_Refrance2 = FirebaseDatabase.instance
              .reference()
              .child("courseSchedule")
              .child(Allteachers_Uid.elementAt(i).toString());
          DB_Refrance2.once().then((DataSnapshot snapshot) {
            Map<dynamic, dynamic> value = snapshot.value;
            Iterable childkey2 = value.keys;
            childkey2.forEach((element) {
              Allteachers_Cource_Detail.add(element);
              for (int j = 0; j < Allteachers_Cource_Detail.length; j++) {
                DatabaseReference DB_Refrance3 = FirebaseDatabase.instance
                    .reference()
                    .child("courseSchedule")
                    .child(Allteachers_Uid.elementAt(i).toString())
                    .child(Allteachers_Cource_Detail.elementAt(j));
                DB_Refrance3.once().then((DataSnapshot snapshot) {
                  String courceid = snapshot.key;
                  course_uid.add(courceid);
                  String courcename = snapshot.value["Courcename"];
                  String day = snapshot.value["Day"];
                  String roomId = snapshot.value["RoomID"];
                  String slotno = snapshot.value["SlotNo"];
                  String slottime = snapshot.value["SlotTime"];
                  String strength = snapshot.value["StudentStrength"];
                  String tuid = snapshot.value["Teacher_Uid"];
                  Cource_Shedule_Model cm = new Cource_Shedule_Model(courcename,
                      day, roomId, slotno, slottime, strength, tuid);
                  Allteachers_Declared_variables.add(cm);
                  for (int res = 0;
                  res < Allteachers_Declared_variables.length;
                  res++) {
                    DatabaseReference DB_Reference_name = FirebaseDatabase
                        .instance
                        .reference()
                        .child("UserTeacher")
                        .child(Allteachers_Declared_variables.elementAt(res)
                        .Teacher_Uid);
                    DB_Reference_name.once().then((DataSnapshot snapshot) {
                      String _teachername = snapshot.value["Name"];
                      String _cuid = course_uid.elementAt(res);
                      String _day = Allteachers_Declared_variables.elementAt(res).Day;
                      String _name = Allteachers_Declared_variables.elementAt(res).Courcename;
                      String _roomId = Allteachers_Declared_variables.elementAt(res).RoomID;
                      String _slotno = Allteachers_Declared_variables.elementAt(res).SlotNo;
                      String _slottime = Allteachers_Declared_variables.elementAt(res).SlotTime;
                      String _strength = Allteachers_Declared_variables.elementAt(res).Student_Strength;
                      String _tuid = Allteachers_Declared_variables.elementAt(res).Teacher_Uid;

                      Regester_Cources_Model aa = new Regester_Cources_Model(
                          _cuid,
                          _name,
                          _day,
                          _roomId,
                          _slotno,
                          _slottime,
                          _strength,
                          _tuid,
                          _teachername);
                      Regestercource.add(aa);
                    });
                  }
                });
              }
            });
          });
        }
        Future.delayed(Duration(seconds: 5), () {
          for (int res = 0; res < Regestercource.length; res++) {
            String select_days = R_Day;
            String slot_time = R_Slot_Time;
            if(Allteachers_Declared_variables.elementAt(res).SlotTime == slot_time && Allteachers_Declared_variables.elementAt(res).Day==select_days){
              statelist.add(true);
            }
            else{
              statelist.add(false);

            }
          }
        });
      });
    });
  }
  void initState() {
    // TODO: implement initState
    Retrive_all_teachers_Classes();
    statelist = new List<bool>();
    Allteachers_Uid = new List<String>();
    Allteachers_Cource_Detail = new List<String>();
    Allteachers_Declared_variables = new List<Cource_Shedule_Model>();

    super.initState();

  }
  void inputData() {
    String cname = R_Cource_Name;
    String selectdays = R_Day;
    String slot = R_Slot_Time;
    String uid = auth.currentUser.uid;
    String Student_Strength = R_Student_Strength;
    String RoomMeeting = R_Room_ID;
    String slotno ="";
    if(slot=="8:00"){
      slotno ="1";

    }
    else if(slot=="9:00"){
      slotno = "2";
    }
    else if(slot == "10:00"){
      slotno="3";
    }
    else if(slot =="11:00"){
      slotno = "4";
    }
    else if(slot =="12:00"){
      slotno="5";
    }

    DatabaseReference reff = FirebaseDatabase.instance
        .reference()
        .child("RegesteredCourceStudent")
        .child(uid);
    reff.push().set({
      "TeacherName":cname,
            "CourceName":cname,
            "SlotTime":slot,
            "Day":selectdays,
            "StudentStrength":Student_Strength,
            "RoomId":RoomMeeting,
    }).whenComplete((){
      Fluttertoast.showToast(
          msg: 'Sucessfully Created',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    });
    // here you write the codes to input the data into firestore
  }



  String R_Teacher_Name,R_Cource_Name,R_Slot_Time,R_Day,R_Student_Strength,R_Room_ID;


  List<Std_Regestered_Cources> Regestercource2 = new List<Std_Regestered_Cources>();
  List<String> Allteachers_Uid2 = new List<String>();
  List<String> course_uid2 = new List<String>();
  List<bool> statelist2 = new List<bool>();
  List<String> Allteachers_Cource_Detail2 = new List<String>();
  List<Student_Regester_Cources_Model> Allteachers_Declared_variables2 = new List<Student_Regester_Cources_Model>();
  void Regester_Student_Cource() {
    FirebaseAuth auth = FirebaseAuth.instance;
    DatabaseReference DB_Refrance =
    FirebaseDatabase.instance.reference().child("RegesteredCourceStudent");
    DB_Refrance.once().then((DataSnapshot snapshot) {
      if(!snapshot.exists){
        inputData();
      }
      else {
        String keys = snapshot.key;
        Map<dynamic, dynamic> value = snapshot.value;
        Iterable childkey1 = value.keys;
        childkey1.forEach((element) {
          Allteachers_Uid2.add(element);
          for (int i = 0; i < Allteachers_Uid2.length; i++) {
            DatabaseReference DB_Refrance2 = FirebaseDatabase.instance
                .reference().child("RegesteredCourceStudent").child(
                Allteachers_Uid2.elementAt(i).toString());
            DB_Refrance2.once().then((DataSnapshot snapshot) {
              Map<dynamic, dynamic> value = snapshot.value;
              Iterable childkey2 = value.keys;
              childkey2.forEach((element) {
                Allteachers_Cource_Detail2.add(element);
                for (int j = 0; j < Allteachers_Cource_Detail2.length; j++) {
                  DatabaseReference DB_Refrance3 = FirebaseDatabase.instance
                      .reference().child("RegesteredCourceStudent").child(Allteachers_Uid2
                      .elementAt(i).toString()).child(Allteachers_Cource_Detail2
                      .elementAt(j));
                  DB_Refrance3.once().then((DataSnapshot snapshot) {

                    String courcename = snapshot.value["Courcename"];
                    String day = snapshot.value["Day"];
                    String roomId = snapshot.value["RoomID"];
                    String slotno = snapshot.value["SlotNo"];
                    String slottime = snapshot.value["SlotTime"];
                    String strength = snapshot.value["StudentStrength"];
                    String tuid = snapshot.value["Teacher_Uid"];

                    Student_Regester_Cources_Model cm = new Student_Regester_Cources_Model(
                        courcename,
                        day,
                        roomId,
                        slotno,
                        slottime,
                        strength,
                        tuid);
                    Allteachers_Declared_variables2.add(cm);
                  });
                }
              });
            });
          }
          Future.delayed(Duration(seconds: 5),(){
            for(int res =0; res<Allteachers_Declared_variables2.length; res++){
              String select_days = R_Day;
              String slot_time = R_Slot_Time;
              if(Allteachers_Declared_variables2.elementAt(res).SlotTime == slot_time && Allteachers_Declared_variables2.elementAt(res).Day==select_days){
                statelist2.add(true);
              }
              else{
                statelist2.add(false);

              }
            }

          });
          Future.delayed(Duration(seconds: 5),(){
            if(statelist2.contains(true)){
              Fluttertoast.showToast(
                  msg: 'Clash in Class',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              statelist2 = new List<bool>();
              Allteachers_Uid2 = new List<String>();
              Allteachers_Cource_Detail2 = new List<String>();
              Allteachers_Declared_variables2= new List<Student_Regester_Cources_Model>();
            }
            else{
              inputData();
              statelist2 = new List<bool>();
              Allteachers_Uid2 = new List<String>();
              Allteachers_Cource_Detail2 = new List<String>();
              Allteachers_Declared_variables2= new List<Student_Regester_Cources_Model>();
            }
          });
        });
      }
    });
  }
  // void Save_Regester_Cource (){
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   if(auth.currentUser.uid==3){
  //     Fluttertoast.showToast(
  //                      msg: 'Class Limit Over',
  //                      toastLength: Toast.LENGTH_SHORT,
  //                      gravity: ToastGravity.CENTER,
  //                      timeInSecForIosWeb: 1,
  //                      backgroundColor: Colors.green,
  //                      textColor: Colors.white,
  //                      fontSize: 16.0);
  //   }else{
  //     DatabaseReference reff = FirebaseDatabase.instance.reference().child("RegesteredCourceStudent").child(auth.currentUser.uid);
  //     reff.push().set({
  //       "TeacherName":R_Teacher_Name,
  //       "CourceName":R_Cource_Name,
  //       "SlotTime":R_Slot_Time,
  //       "Day":R_Day,
  //       "StudentStrength":R_Student_Strength,
  //       "RoomId":R_Room_ID,
  //     }).whenComplete((){
  //       Fluttertoast.showToast(
  //           msg: 'Sucessfully Created',
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //       //Navigator.pop(context);
  //     });
  //   }
  //
  //
  //
  // }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Regester Cources"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: Regestercource.length,
          itemBuilder: (BuildContext ctx, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 225,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurple,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurpleAccent.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(1, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        children: [
                          Text(
                            'Teacher Name: ',
                            style: TextColour,
                          ),
                          Spacer(),
                          Text(
                           R_Teacher_Name= Regestercource[index].Teacher_Name,
                            style: TextColour,
                          ),
                        ],
                      ),
                      Divider(height: 5, thickness: 2,),
                      Row(
                        children: [
                          Text(
                            'Cource Name: ',
                            style: TextColour,
                          ),
                          Spacer(),
                          Text(
                           R_Cource_Name= Regestercource[index].Courcename,
                            style: TextColour,
                          ),
                        ],
                      ),
                      Divider(height: 5, thickness: 2,),
                      Row(
                        children: [
                          Text(
                            'Slot Time : ',
                            style: TextColour,
                          ),
                          Spacer(),
                          Text(
                           R_Slot_Time= Regestercource[index].SlotTime,
                            style: TextColour,
                          ),
                        ],
                      ),
                      Divider(height: 5, thickness: 2,),
                      Row(
                        children: [
                          Text(
                            'Day : ',
                            style: TextColour,
                          ),
                          Spacer(),
                          Text(
                          R_Day=  Regestercource[index].Day,
                            style: TextColour,
                          ),
                        ],
                      ),
                      Divider(height: 5, thickness: 2,),
                      Row(
                        children: [
                          Text(
                            'Student Strength : ',
                            style: TextColour,
                          ),
                          Spacer(),
                          Text(
                           R_Student_Strength= Regestercource[index].Student_Strength,
                            style: TextColour,
                          ),
                        ],
                      ),
                      Divider(height: 5, thickness: 2,),
                      Row(
                        children: [
                          Text(
                            'Room ID : ',
                            style: TextColour,
                          ),
                          Spacer(),
                          Text(
                           R_Room_ID= Regestercource[index].RoomID,
                            style: TextColour,
                          ),
                        ],
                      ),
                      Divider(height: 5, thickness: 2,),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          Regester_Student_Cource();
                        },
                        child: Container(
                          height:50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          child: Center(
                            child: Text(
                              "Regester Cource",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
