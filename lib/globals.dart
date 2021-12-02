// // TODO Implement this library.
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// String CourceName;
// String StartHour;
// String Minutes;
// String RoomId;
// String StudentStrength;
// String TeacherUid;
// String CourceDuration;
//
// // String STD_Db_CourceName;
// List<String>STD_Db_CourceName= new List<String>();
// List<String>STD_Db_StartHour= new List<String>();
// List<String>STD_Db_Minutes= new List<String>();
// List<String>STD_Db_RoomId= new List<String>();
// List<String>STD_Db_StudentStrength= new List<String>();
// List<String>STD_Db_TeacherUid= new List<String>();
// List<String>STD_Db_CourceDuration= new List<String>();
// // String STD_Db_StartHour;
// // String STD_Db_Minutes;
// // String STD_Db_RoomId;
// // String STD_Db_StudentStrength;
// // String STD_Db_TeacherUid;
// // String STD_Db_CourceDuration;
//
// List<String> Allteachers_Uid = new List<String>();
// List<String> Allteachers_Cource_Detail = new List<String>();
// List<String> Allteachers_Declared_variables = new List<String>();
// void Retrive_all_teachers_Classes() {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   DatabaseReference DB_Refrance =
//       FirebaseDatabase.instance.reference().child("courseSchedule");
//   DB_Refrance.once().then((DataSnapshot snapshot) {
//     String keys = snapshot.key;
//     Map<dynamic, dynamic> value = snapshot.value;
//     Iterable childkey1 = value.keys;
//     childkey1.forEach((element) {
//       Allteachers_Uid.add(element);
//       for (int i = 0; i < Allteachers_Uid.length; i++) {
//         DatabaseReference DB_Refrance2 = FirebaseDatabase.instance
//             .reference()
//             .child("courseSchedule")
//             .child(Allteachers_Uid.elementAt(i));
//         DB_Refrance2.once().then((DataSnapshot snapshot) {
//           Map<dynamic, dynamic> value = snapshot.value;
//           Iterable childkey2 = value.keys;
//           childkey2.forEach((element) {
//             Allteachers_Cource_Detail.add(element);
//             for (int j = 0; j < Allteachers_Cource_Detail.length; j++) {
//               DatabaseReference DB_Refrance3 = FirebaseDatabase.instance
//                   .reference()
//                   .child("courseSchedule")
//                   .child(Allteachers_Cource_Detail.elementAt(j));
//               DB_Refrance3.once().then((DataSnapshot snapshot) {
//                 Map<dynamic, dynamic> value = snapshot.value;
//                 Iterable childkey3 = value.keys;
//                 childkey3.forEach((element) {
//                   Allteachers_Declared_variables.add(element);
//                   for (int k = 0;
//                       k < Allteachers_Declared_variables.length;
//                       k++) {
//                     DatabaseReference DB_Refrance4 = FirebaseDatabase.instance
//                         .reference()
//                         .child("courseSchedule")
//                         .child(Allteachers_Declared_variables.elementAt(k));
//                     DB_Refrance4.once().then((DataSnapshot snapshot) {
//                       STD_Db_CourceName = snapshot.value['Courcename'];
//                       STD_Db_StartHour = snapshot.value['Hours'];
//                       STD_Db_Minutes = snapshot.value['Minutes'];
//                       STD_Db_CourceDuration = snapshot.value['courceDuration'];
//                       STD_Db_RoomId = snapshot.value['Room ID'];
//                       STD_Db_StudentStrength =
//                           snapshot.value['Student Strength'];
//                       STD_Db_TeacherUid = snapshot.value['Teacher_Uid'];
//                     });
//                   }
//                 });
//               });
//             }
//
//           });
//         });
//       }
//     });
//   });
// }
// // STD_Db_CourceName  = snapshot.value['Courcename'];
// // STD_Db_StartHour = snapshot.value['Hours'];
// // STD_Db_Minutes  = snapshot.value['Minutes'];
// // STD_Db_CourceDuration = snapshot.value['courceDuration'];
// // STD_Db_RoomId = snapshot.value['Room ID'];
// // STD_Db_StudentStrength = snapshot.value['Student Strength'];
// // STD_Db_TeacherUid  = snapshot.value['Teacher_Uid'];
//
// void RetrieveDataSTD() async {
//   List<String> childkeyslist = new List<String>();
//   FirebaseAuth auth = FirebaseAuth.instance;
//   DatabaseReference databaseRef = FirebaseDatabase.instance
//       .reference()
//       .child("courseSchedule")
//       .child(auth.currentUser.uid);
//   databaseRef.once().then((DataSnapshot snapshot) {
//     String keys = snapshot.key;
//     if (keys == auth.currentUser.uid) {
//       Map<dynamic, dynamic> value = snapshot.value;
//       Iterable childkey = value.keys;
//       childkey.forEach((element) {
//         childkeyslist.add(element);
//         for (int i = 0; i < childkeyslist.length; i++) {
//           DatabaseReference reff = FirebaseDatabase.instance
//               .reference()
//               .child("courseSchedule")
//               .child(auth.currentUser.uid)
//               .child(childkeyslist.elementAt(i));
//           reff.once().then((DataSnapshot dataSnapshot) {
//             CourceName = dataSnapshot.value['Courcename'];
//             StartHour = dataSnapshot.value['Hours'];
//             Minutes = dataSnapshot.value['Minutes'];
//             CourceDuration = dataSnapshot.value['courceDuration'];
//             RoomId = dataSnapshot.value['Room ID'];
//             StudentStrength = dataSnapshot.value['Student Strength'];
//             TeacherUid = dataSnapshot.value['Teacher_Uid'];
//           });
//         }
//       });
//     }
//   });
// }
