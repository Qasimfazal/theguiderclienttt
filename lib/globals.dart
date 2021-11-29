// TODO Implement this library.


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

String CourceName ;
String StartHour;
String Minutes ;
String RoomId;
String StudentStrength ;
String TeacherUid  ;
String CourceDuration;

void RetrieveDataSTD() async {
  List<String> childkeyslist = new List<String>();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance
      .reference()
      .child("courseSchedule")
      .child(auth.currentUser.uid);
  databaseRef.once().then((DataSnapshot snapshot) {
    String keys = snapshot.key;
    if (keys == auth.currentUser.uid) {
      Map<dynamic, dynamic> value = snapshot.value;
      Iterable childkey = value.keys;
      childkey.forEach((element) {
        childkeyslist.add(element);
        for (int i = 0; i < childkeyslist.length; i++) {
          DatabaseReference reff = FirebaseDatabase.instance
              .reference()
              .child("courseSchedule")
              .child(auth.currentUser.uid)
              .child(childkeyslist.elementAt(i));
          reff.once().then((DataSnapshot dataSnapshot) {
            CourceName = dataSnapshot.value['Courcename'];
            StartHour= dataSnapshot.value['Hours'];
            Minutes = dataSnapshot.value['Minutes'];
            CourceDuration = dataSnapshot.value['courceDuration'];
            RoomId= dataSnapshot.value['Room ID'];
            StudentStrength= dataSnapshot.value['Student Strength'];

            TeacherUid = dataSnapshot.value['Teacher_Uid'];


            ///
            // String CourceName = DBCourceName;
            // String StartHour = DBhour;
            // String Minutes =DBminute;
            // String RoomId=DB_Roomid ;
            // String StudentStrength =DB_StudentStrength;
            // String TeacherUid = DB_TeacherUid;
            // String CourceDuration =DB_cduration;
          });
        }
      });
    }

  });
}