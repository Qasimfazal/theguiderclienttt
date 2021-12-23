import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:theguiderclienttt/model/Cource_Shedule_Model.dart';
import 'package:theguiderclienttt/model/Mycoursesmodel.dart';
import 'package:theguiderclienttt/model/Regester_Cources.dart';
String Student_Name;
List<Regester_Cources_Model> Regestercource = new List<Regester_Cources_Model>();
List<String> Allteachers_Uid = new List<String>();
List<String> course_uid = new List<String>();
List<bool> statelist = new List<bool>();
List<String> Allteachers_Cource_Detail = new List<String>();
List<Cource_Shedule_Model> Allteachers_Declared_variables = new List<Cource_Shedule_Model>();
void Retrive_all_teachers_Classes() {

  DatabaseReference DB_Refrance = FirebaseDatabase.instance.reference().child("courseSchedule");
  DB_Refrance.once().then((DataSnapshot dataSnapshot) {
    Map<dynamic, dynamic> value = dataSnapshot.value;
    Iterable childkey1 = value.keys;
    childkey1.forEach((element) {
      Allteachers_Uid.add(element);
    });
    for(int i =0; i<Allteachers_Uid.length; i++){
      DatabaseReference DB_Refrance1 = FirebaseDatabase.instance.reference().child("courseSchedule").child(Allteachers_Uid.elementAt(i));
      DB_Refrance1.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> value = snapshot.value;
        Iterable childkey2 = value.keys;
        childkey2.forEach((element) {
          Allteachers_Cource_Detail.add(element);
        });
        for(int k=0; k<Allteachers_Cource_Detail.length; k++){
          DatabaseReference DB_Refrance2 = FirebaseDatabase.instance.reference().child("courseSchedule").child(Allteachers_Uid.elementAt(i)).child(Allteachers_Cource_Detail.elementAt(k));
          DB_Refrance2.once().then((DataSnapshot dataSnapshot1) {
            DatabaseReference DB_Refrance2 = FirebaseDatabase.instance.reference().child("courseSchedule").child(Allteachers_Uid.elementAt(i)).child(Allteachers_Cource_Detail.elementAt(k));
            String _cuid = dataSnapshot1.key;
            String _day = dataSnapshot1.value["Day"];
            String _name = dataSnapshot1.value["Courcename"];
            String _roomId = dataSnapshot1.value["RoomID"];
            String _slotno = dataSnapshot1.value["SlotNo"];
            String _slottime = dataSnapshot1.value["SlotTime"];
            String _strength = dataSnapshot1.value["StudentStrength"];
            String _tuid = dataSnapshot1.value["Teacher_Uid"];
            DatabaseReference DB_Refrance3 = FirebaseDatabase.instance.reference().child("UserTeacher").child(_tuid);
            DB_Refrance3.once().then((DataSnapshot dataSnapshot3){
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
      });
    }
  });

 /* FirebaseAuth auth = FirebaseAuth.instance;
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
            Regestercource.clear();
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

    });
  });*/
}


//
// List<MyCoursesModel> myCoursesList = new List<MyCoursesModel>();
// void Retrieve_MyCourtses(){
//   FirebaseAuth auth = FirebaseAuth.instance;
//   DatabaseReference reff = FirebaseDatabase.instance.reference().child("StudentCourse").child(auth.currentUser.uid);
//   reff.once().then((DataSnapshot snapshot){
//
//
//
//     String RoomID = snapshot.value['RoomID'];
//     String Courcename = snapshot.value['Courcename'];
//     String Teacher_Uid = snapshot.value['Teacher_Uid'];
//     String SlotNo = snapshot.value['SlotNo'];
//     String SlotTime = snapshot.value['SlotTime'];
//     String Absents = snapshot.value['Absents'];
//     String Cid = snapshot.key;
//     String Day = snapshot.value['Day'];
//     String StudentStrength = snapshot.value['StudentStrength'];
//
//     S_Room = RoomID;
//     S_Courcename =Courcename;
//     S_Day = Day;
//     S_Absents = Absents;
//     S_SlotNo = SlotNo;
//     S_SlotTime = SlotTime;
//
//     MyCoursesModel mcm = new MyCoursesModel(RoomID, Courcename, Cid, Teacher_Uid, SlotNo, SlotTime, Absents, Day, StudentStrength);
//     myCoursesList.add(mcm);
//
//   });
// }


List<MyCoursesModel> myCoursesList =  [];
List<String> Student_CourceList = [];

// void Retrieve_MyCourtses() {
//   myCoursesList.clear();
//   FirebaseAuth auth = FirebaseAuth.instance;
//   DatabaseReference DB_Refrance = FirebaseDatabase.instance.reference().child(
//       "StudentCourse").child(auth.currentUser.uid);
//   DB_Refrance.once().then((DataSnapshot snapshot) {
//     Map<dynamic, dynamic> values = snapshot.value;
//     Iterable childkey1 = values.keys;
//     childkey1.forEach((element) {
//       Student_CourceList.add(element);
//     });
//
//     // Future.delayed(Duration(seconds: 5),(){
//     //   for(int res =0; res<student_register_cource_list.length; res++){
//     //     String select_days = R_Day;
//     //     String slot_time = R_Slot_Time;
//     //     if(student_register_cource_list.elementAt(res).SlotTime == slot_time && student_register_cource_list.elementAt(res).Day==select_days){
//     //       statelist.add(true);
//     //     }
//     //     else{
//     //       statelist.add(false);
//     //
//     //     }
//     //   }
//     //
//     // });
//     // Future.delayed(Duration(seconds: 5),(){
//     //   if(statelist.contains(true)){
//     //     Fluttertoast.showToast(
//     //         msg: 'Clash in Class',
//     //         toastLength: Toast.LENGTH_SHORT,
//     //         gravity: ToastGravity.CENTER,
//     //         timeInSecForIosWeb: 1,
//     //         backgroundColor: Colors.red,
//     //         textColor: Colors.white,
//     //         fontSize: 16.0);
//     //     statelist = new List<bool>();
//     //     student_course_uidlist = new List<String>();
//     //
//     //     student_register_cource_list= new List<Student_Regester_Cources_Model>();
//     //   }
//     //   else{
//     //     inputData();
//     //     statelist = new List<bool>();
//     //     student_course_uidlist = new List<String>();
//     //     student_register_cource_list= new List<Student_Regester_Cources_Model>();
//     //   }
//     // });
//
//   });
//
//   // Future.delayed(Duration(seconds: 3), () {
//     for (int res = 0; res < Student_CourceList.length; res++) {
//       DatabaseReference DB_Reference1 =
//       FirebaseDatabase.instance.reference().child("StudentCourse").child(
//           auth.currentUser.uid).child(
//           Student_CourceList.elementAt(res).toString());
//       DB_Reference1.once().then((DataSnapshot snapshot) {
//         String RoomID = snapshot.value['RoomID'];
//         String Courcename = snapshot.value['Courcename'];
//         String Teacher_Uid = snapshot.value['Teacher_Uid'];
//         String SlotNo = snapshot.value['SlotNo'];
//         String SlotTime = snapshot.value['SlotTime'];
//         String Absents = snapshot.value['Absents'];
//         String Cid = snapshot.key;
//         String Day = snapshot.value['Day'];
//         String StudentStrength = snapshot.value['StudentStrength'];
//         // MyCoursesModel mcm = new MyCoursesModel(
//         //     RoomID,
//         //     Courcename,
//         //     Cid,
//         //     Teacher_Uid,
//         //     SlotNo,
//         //     SlotTime,
//         //     Absents,
//         //     Day,
//         //     StudentStrength);
//         myCoursesList.add(MyCoursesModel(
//             RoomID: RoomID, Courcename: Courcename, cid: Cid,Teacher_Uid: Teacher_Uid, SlotNo: SlotNo,
//             SlotTime: SlotTime, Absents: Absents, Day:Day ,StudentStrength:StudentStrength
//
//
//         ));
//       });
//     }
//   // });
//
//
//   // void Retrieve_MyCourtses(){
//   // FirebaseAuth auth = FirebaseAuth.instance;
//   // DatabaseReference reff = FirebaseDatabase.instance.reference().child("StudentCourse").child(auth.currentUser.uid);
//   // reff.once().then((DataSnapshot snapshot){
//   //   Map<dynamic, dynamic> value = snapshot.value;
//   //   Iterable childkey1 = value.keys;
//   //   childkey1.forEach((element) {
//   //     Student_CourceList.add(element);
//   //     DatabaseReference reff = FirebaseDatabase.instance.reference().child("StudentCourse").child();
//   //
//   //     for(int res = 0; res<Student_CourceList.length; res++){
//   //       Map<dynamic, dynamic> value = snapshot.value;
//   //       Iterable childkey1 = value.keys;
//   //       childkey1.forEach((element) {
//   //         Student_CourceList.add(element);
//   //   String RoomID = snapshot.value['RoomID'];
//   //   String Courcename = snapshot.value['Courcename'];
//   //   String Teacher_Uid = snapshot.value['Teacher_Uid'];
//   //   String SlotNo = snapshot.value['SlotNo'];
//   //   String SlotTime = snapshot.value['SlotTime'];
//   //   String Absents = snapshot.value['Absents'];
//   //   String Cid = snapshot.key;
//   //   String Day = snapshot.value['Day'];
//   //   String StudentStrength = snapshot.value['StudentStrength'];
//   //   MyCoursesModel mcm = new MyCoursesModel(RoomID, Courcename, Cid, Teacher_Uid, SlotNo, SlotTime, Absents, Day, StudentStrength);
//   //    myCoursesList.add(mcm);
//   //
//   //         });}});
//   //   }
//   //   );}
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       // title: Text("My Cources List"),
//   //     ),
//   //     body: Column(
//   //       children: [
//   //         Container(
//   //           height: MediaQuery
//   //               .of(context)
//   //               .size
//   //               .height / 1.2,
//   //           width: MediaQuery
//   //               .of(context)
//   //               .size
//   //               .width,
//   //           child: ListView.builder(
//   //             padding: EdgeInsets.all(5),
//   //             itemCount: myCoursesList.length,
//   //             itemBuilder: (BuildContext ctx, index) {
//   //               return Padding(
//   //                 padding: const EdgeInsets.all(10.0),
//   //                 child: InkWell(
//   //                   onTap: () {
//   //                     // Navigator.of(context).push(MaterialPageRoute(
//   //                     //     builder: (BuildContext context) =>
//   //                     //         CourceList[index].navigation));
//   //                   },
//   //                   child: Container(
//   //                     height: 100,
//   //                     decoration: BoxDecoration(
//   //                       // image: DecorationImage(
//   //                       //   image: AssetImage(CourceList[index].image??'null'),
//   //                       //   fit: BoxFit.fill,
//   //                       // ),
//   //                       //color: const Color(0xff7c94b6),
//   //                       border: Border.all(
//   //                         color: Colors.deepPurple,
//   //                         width: 1,
//   //                       ),
//   //                       boxShadow: [
//   //                         BoxShadow(
//   //                           color: Colors.deepPurpleAccent.withOpacity(0.1),
//   //                           spreadRadius: 2,
//   //                           blurRadius: 7,
//   //                           offset: Offset(
//   //                               1, 3), // changes position of shadow
//   //                         ),
//   //                       ],
//   //                       borderRadius: BorderRadius.circular(4),
//   //                     ),
//   //                     child: Column(
//   //                       mainAxisAlignment: MainAxisAlignment.end,
//   //                       children: [
//   //                         Text(myCoursesList[index].RoomID ?? 'null'),
//   //                         Text(myCoursesList[index].SlotTime ?? 'null'),
//   //                         Text(myCoursesList[index].SlotNo ?? "null"),
//   //                         Text(myCoursesList[index].Absents ?? "null"),
//   //                         Text(myCoursesList[index].Courcename ?? "null"),
//   //                         // Text(myCoursesList[index].),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                 ),
//   //               );
//   //             },
//   //           ),
//   //         )
//   //       ],
//   //     ),
//   //   );
//   // }
// }

String TRANASfer_Room_Id;
String TRANASfer_Slot_time;
String TRANASfer_Slot_No;
String TRANASfer_Absence;
String TRANASfer_Cource_Name;
String cid ;
String tid;

Future<String> RetrieveData(){
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference reference = FirebaseDatabase.instance.reference().child("UserClient").child(auth.currentUser.uid);
  reference.once().then((DataSnapshot snapshot){

    Student_Name = snapshot.value["Name"];

   // cid = myCoursesList[position].cid;
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (BuildContext context) =>
    //         Meeting(TRANASfer_Room_Id,TRANASfer_Slot_time,TRANASfer_Slot_No,TRANASfer_Absence,TRANASfer_Cource_Name,cid,tid, name)));

  });
}
