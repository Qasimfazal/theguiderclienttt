import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:theguiderclienttt/model/Mycoursesmodel.dart';

import '../globals.dart';

class Data {
  static void Retrieve_MyCourtses() async {
    var value;
    print("sorry");
    myCoursesList.clear();
    Student_CourceList.clear();
    FirebaseAuth auth = FirebaseAuth.instance;
    DatabaseReference DB_Refrance = await FirebaseDatabase.instance
        .reference()
        .child("StudentCourse")
        .child(auth.currentUser.uid);
    DB_Refrance.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      Iterable childkey1 = values.keys;
      childkey1.forEach((element) {
        Student_CourceList.add(element);
        // DatabaseReference DB_Reference1 =
        // FirebaseDatabase.instance.reference().child("StudentCourse").child(
        //     auth.currentUser.uid).child(
        //     Student_CourceList.elementAt(element).toString());
        // DB_Reference1.once().then((DataSnapshot snapshot) {
        //   value = snapshot;
        //   myCoursesList.add(MyCoursesModel(
        //       RoomID: value.value['RoomID'],
        //       Courcename: value.value['Courcename'],
        //       cid: value.key,
        //       Teacher_Uid: value.value['Teacher_Uid'],
        //       SlotNo: value.value['SlotNo'],
        //       SlotTime: value.value['SlotTime'],
        //       Absents: value.value['Absents'],
        //       Day: value.value['Day'],
        //       StudentStrength: value.value['StudentStrength']
        //   ));
        // });
      });

      // Future.delayed(Duration(seconds: 5),(){
      //   for(int res =0; res<student_register_cource_list.length; res++){
      //     String select_days = R_Day;
      //     String slot_time = R_Slot_Time;
      //     if(student_register_cource_list.elementAt(res).SlotTime == slot_time && student_register_cource_list.elementAt(res).Day==select_days){
      //       statelist.add(true);
      //     }
      //     else{
      //       statelist.add(false);
      //
      //     }
      //   }
      //
      // });
      // Future.delayed(Duration(seconds: 5),(){
      //   if(statelist.contains(true)){
      //     Fluttertoast.showToast(
      //         msg: 'Clash in Class',
      //         toastLength: Toast.LENGTH_SHORT,
      //         gravity: ToastGravity.CENTER,
      //         timeInSecForIosWeb: 1,
      //         backgroundColor: Colors.red,
      //         textColor: Colors.white,
      //         fontSize: 16.0);
      //     statelist = new List<bool>();
      //     student_course_uidlist = new List<String>();
      //
      //     student_register_cource_list= new List<Student_Regester_Cources_Model>();
      //   }
      //   else{
      //     inputData();
      //     statelist = new List<bool>();
      //     student_course_uidlist = new List<String>();
      //     student_register_cource_list= new List<Student_Regester_Cources_Model>();
      //   }
      // });
    }).then((value) async {
      await datacalling();
    });
  }

  static void datacalling() async {
    myCoursesList.clear();
    FirebaseAuth auth = FirebaseAuth.instance;
    for (int res = 0; res < Student_CourceList.length; res++) {
      // for(var val in Student_CourceList){
      //
      // }

      DatabaseReference DB_Reference1 = await FirebaseDatabase.instance
          .reference()
          .child("StudentCourse")
          .child(auth.currentUser.uid)
          .child(Student_CourceList.elementAt(res).toString());
      await DB_Reference1.once().then((DataSnapshot snapshot) {
        // value = snapshot;
        myCoursesList.add(MyCoursesModel(
            RoomID: snapshot.value['RoomID'],
            Courcename: snapshot.value['Courcename'],
            cid: snapshot.key,
            Teacher_Uid: snapshot.value['Teacher_Uid'],
            SlotNo: snapshot.value['SlotNo'],
            SlotTime: snapshot.value['SlotTime'],
            Absents: snapshot.value['Absents'],
            Day: snapshot.value['Day'],
            StudentStrength: snapshot.value['StudentStrength']));
      });

      // print(value);
    }
  }

  static  Future<String> RetrieveData() {
    FirebaseAuth auth = FirebaseAuth.instance;
    DatabaseReference reference = FirebaseDatabase.instance.reference().child(
        "UserClient").child(auth.currentUser.uid);
    reference.once().then((DataSnapshot snapshot) {
      Student_Name = snapshot.value["Name"];
    });
  }
}
