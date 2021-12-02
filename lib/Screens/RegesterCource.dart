import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:theguiderclienttt/List/MAdarsaList/MyCourceList.dart';
import 'package:theguiderclienttt/Screens/Teacher_Cource_Detail.dart';
import 'package:theguiderclienttt/globals.dart';
import 'package:theguiderclienttt/model/Cource_Shedule_Model.dart';
import 'package:theguiderclienttt/model/Regester_Cources.dart';

class RegesterCourceList extends StatefulWidget {
 // const courceList({Key key}) : super(key: key);

  @override
  _RegesterCourceListState createState() => _RegesterCourceListState();
}

class _RegesterCourceListState extends State<RegesterCourceList> {
  @override
  List<Regester_Cources_Model> Regestercource =new List<Regester_Cources_Model>();
  List<String> Allteachers_Uid = new List<String>();
  List<String> course_uid = new List<String>();
  List<bool> statelist = new List<bool>();
  List<String> Allteachers_Cource_Detail = new List<String>();
  List<Cource_Shedule_Model> Allteachers_Declared_variables = new List<Cource_Shedule_Model>();
  void initState() {
    // TODO: implement initState

    statelist = new List<bool>();
    Allteachers_Uid = new List<String>();
    Allteachers_Cource_Detail = new List<String>();
    Allteachers_Declared_variables= new List<Cource_Shedule_Model>();
    Retrive_all_teachers_Classes();
    super.initState();
  }

  void Retrive_all_teachers_Classes() {
    FirebaseAuth auth = FirebaseAuth.instance;
    DatabaseReference DB_Refrance =
    FirebaseDatabase.instance.reference().child("courseSchedule");
    DB_Refrance.once().then((DataSnapshot snapshot) {

        String keys = snapshot.key;
        Map<dynamic, dynamic> value = snapshot.value;
        Iterable childkey1 = value.keys;
        childkey1.forEach((element) {
          Allteachers_Uid.add(element);
          for (int i = 0; i < Allteachers_Uid.length; i++) {
            DatabaseReference DB_Refrance2 = FirebaseDatabase.instance
                .reference().child("courseSchedule").child(
                Allteachers_Uid.elementAt(i).toString());
            DB_Refrance2.once().then((DataSnapshot snapshot) {
              Map<dynamic, dynamic> value = snapshot.value;
              Iterable childkey2 = value.keys;
              childkey2.forEach((element) {
                Allteachers_Cource_Detail.add(element);
                for (int j = 0; j < Allteachers_Cource_Detail.length; j++) {
                  DatabaseReference DB_Refrance3 = FirebaseDatabase.instance
                      .reference().child("courseSchedule").child(Allteachers_Uid
                      .elementAt(i).toString()).child(Allteachers_Cource_Detail
                      .elementAt(j));
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
                    Cource_Shedule_Model cm = new Cource_Shedule_Model(courcename, day, roomId, slotno, slottime, strength, tuid);
                    Allteachers_Declared_variables.add(cm);
                    for(int res =0; res<Allteachers_Declared_variables.length; res++){
                      DatabaseReference DB_Reference_name = FirebaseDatabase.instance.reference().child("UserTeacher").child(Allteachers_Declared_variables.elementAt(res).Teacher_Uid);
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

                        Regester_Cources_Model aa= new Regester_Cources_Model(
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
          }  Future.delayed(Duration(seconds: 5),(){
            for(int res =0; res<Regestercource.length; res++){
             // String select_days = Select_Day;
             // String slot_time = _course_duration;
              // if(Allteachers_Declared_variables.elementAt(res).SlotTime == slot_time && Allteachers_Declared_variables.elementAt(res).Day==select_days){
              //   statelist.add(true);
              // }
              // else{
              //   statelist.add(false);
              //
              // }
            }

          });

        });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text( "Cources Lis"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.2,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: EdgeInsets.all(5),
              itemCount: Regestercource.length,
              itemBuilder: (BuildContext ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>Detail_of_CourcesList()));
                    },
                    child: Container(
                      height: 150,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Text('data'),
                          Text(Regestercource[index].Teacher_Name,style: TextStyle(color: Colors.black45),),
                          Text(Regestercource[index].Courcename),
                          Text(Regestercource[index].SlotTime),
                          Text(Regestercource[index].Day),
                          Text(Regestercource[index].Student_Strength),
                          Text(Regestercource[index].RoomID),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
