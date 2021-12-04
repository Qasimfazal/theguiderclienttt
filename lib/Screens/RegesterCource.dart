import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:theguiderclienttt/Config.dart';
import 'package:theguiderclienttt/globals.dart';
import 'package:theguiderclienttt/model/Student_Regesterd_Model.dart';

class RegesterCourceList extends StatefulWidget {
  // const courceList({Key key}) : super(key: key);

  @override
  _RegesterCourceListState createState() => _RegesterCourceListState();
}

class _RegesterCourceListState extends State<RegesterCourceList> {
  @override
  FirebaseAuth auth = FirebaseAuth.instance;

  String R_Teacher_Name,R_Cource_Name,R_Slot_Time,R_Day,R_Student_Strength,R_Room_ID , R_TUID, R_CID;
  List<String> student_course_uidlist = new List<String>();
  List<Student_Regester_Cources_Model>  student_register_cource_list = new List<Student_Regester_Cources_Model>();
  List<bool> statelist =new List<bool>();


  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void Retrive_all_student_Classes() {
    FirebaseAuth auth = FirebaseAuth.instance;
    DatabaseReference DB_Refrance =
    FirebaseDatabase.instance.reference().child("StudentCourse").child(auth.currentUser.uid);
    DB_Refrance.once().then((DataSnapshot snapshot) {
      if (!snapshot.exists) {
        inputData();
      }
      else {
        Map<dynamic, dynamic> value = snapshot.value;
        Iterable childkey1 = value.keys;
        childkey1.forEach((element) {
          student_course_uidlist.add(element);
        });
        for(int res = 0; res<student_course_uidlist.length; res++){
          DatabaseReference DB_Reference1 =
          FirebaseDatabase.instance.reference().child("StudentCourse").child(auth.currentUser.uid).child(student_course_uidlist.elementAt(res));
          DB_Reference1.once().then((DataSnapshot snapshot){
            String cid = snapshot.key;
            String Courcename = snapshot.value["Courcename"];
            String Day = snapshot.value["Day"];
            String RoomID = snapshot.value["RoomID"];
            String SlotTime = snapshot.value["SlotTime"];
            String SlotNo = snapshot.value["SlotNo"];
            String Student_Strength = snapshot.value["StudentStrength"];
            String Teacher_Uid = snapshot.value["Teacher_Uid"];
            Student_Regester_Cources_Model srcm = new Student_Regester_Cources_Model(cid, Courcename, Day, RoomID, SlotNo, SlotTime, Student_Strength, Teacher_Uid);
            student_register_cource_list.add(srcm);

          });
        }
        Future.delayed(Duration(seconds: 5),(){
          for(int res =0; res<student_register_cource_list.length; res++){
            String select_days = R_Day;
            String slot_time = R_Slot_Time;
            if(student_register_cource_list.elementAt(res).SlotTime == slot_time && student_register_cource_list.elementAt(res).Day==select_days){
              statelist.add(true);
            }
            else{
              statelist.add(false);

            }
          }

        });
        Future.delayed(Duration(seconds: 5),(){
          if(statelist.contains(true)){
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

            student_register_cource_list= new List<Student_Regester_Cources_Model>();
          }
          else{
            inputData();
            statelist = new List<bool>();
            student_course_uidlist = new List<String>();
            student_register_cource_list= new List<Student_Regester_Cources_Model>();
          }
        });
      }
    });

  }


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
                          R_TUID = Regestercource[index].Teacheruid;
                          R_CID = Regestercource[index].id;
                      //    Regester_Student_Cource();
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

  void inputData() {
    String slotno="";
    if(R_Slot_Time=="8:00"){
      slotno ="1";

    }
    else if(R_Slot_Time=="9:00"){
      slotno = "2";
    }
    else if(R_Slot_Time == "10:00"){
      slotno="3";
    }
    else if(R_Slot_Time =="11:00"){
      slotno = "4";
    }
    else if(R_Slot_Time =="12:00"){
      slotno="5";
    }

    DatabaseReference reff = FirebaseDatabase.instance
        .reference()
        .child("StudentCourse")
        .child(auth.currentUser.uid);
    reff.child(R_CID).set({

      'RoomID' : R_Room_ID,
      'Courcename': R_Cource_Name,
      'Teacher_Uid': R_TUID,
      'SlotNo': slotno,
      'SlotTime':R_Slot_Time,
      'Absents':"0",
      'Day':R_Day,
      'StudentStrength': R_Student_Strength,
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
  }
}
