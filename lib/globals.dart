import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:theguiderclienttt/model/Cource_Shedule_Model.dart';
import 'package:theguiderclienttt/model/Regester_Cources.dart';

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
