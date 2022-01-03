import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:theguiderclienttt/globals.dart';
import 'package:theguiderclienttt/model/StudentAttendance.dart';

class Attendanceview extends StatefulWidget {
  const Attendanceview({Key key}) : super(key: key);

  @override
  _AttendanceviewState createState() => _AttendanceviewState();
}

class _AttendanceviewState extends State<Attendanceview> {
  @override
  bool _loading = true;
  void initState() {

    // TODO: implement initState
    super.initState();
    forAttendancefetchingStudentCourses(auth.currentUser.uid);
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _loading = false;

      });
    });
  }
  @override
  FirebaseAuth auth = FirebaseAuth.instance;
  List<String> studentIDList =[];
  List<StudentAttendance> studentCourseAttendance = [];

  Future<void> forAttendancefetchingStudentCourses(String sid) async {
    studentIDList.clear();
    studentCourseAttendance.clear();
    DatabaseReference reference = await FirebaseDatabase.instance.reference().child("StudentCourse").child(sid);
    reference.once().then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> value = dataSnapshot.value;
      Iterable childkey1 = value.keys;
      childkey1.forEach((element) {
        studentIDList.add(element);
      });
    }).then((value) async {
      await fetchCoursesAttendanceDetails(sid);
    });
  }

  fetchCoursesAttendanceDetails(String sid) async {
    for(int i=0; i<studentIDList.length; i++){
      DatabaseReference refer = await FirebaseDatabase.instance.reference().child("StudentCourse").child(sid).child(studentIDList.elementAt(i));
      refer.once().then((DataSnapshot dataSnapshot){
        String coursename = dataSnapshot.value["Courcename"];
        String absent = dataSnapshot.value["Absents"];
        String present = dataSnapshot.value["Present"];
        StudentAttendance student =new StudentAttendance(coursename, absent, present);
        studentCourseAttendance.add(student);

      });
    }
  }


  Widget build(BuildContext context) {
    return _loading ? Center(child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          //   color: Colors.red,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(143, 148, 251, .2),
                  blurRadius: 20.0,
                  offset: Offset(0, 10))
            ]),
        child: CircularProgressIndicator())) : Scaffold(
        body: Column(
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
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/light-1.png'))),
                    ),
                  ),
                  Positioned(
                    left: 140,
                    width: 80,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/light-2.png'))),
                    ),
                  ),
                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/clock.png'))),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 30,
                    child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Row(
                            children: [
                              // IconButton(
                              //   onPressed: () {
                              //     myCoursesList.clear();
                              //     Student_CourceList.clear();
                              //     Navigator.pop(context);
                              //   },
                              //   icon: const Icon(Icons.arrow_back),
                              // ),
                              InkWell(
                                  onTap: () {
                                    // myCoursesList.clear();
                                    // Student_CourceList.clear();
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios_sharp,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 5,
                              ),

                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text('View Attendance',style: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.w300),),
            ),
            Expanded(
            //  height: MediaQuery.of(context).size.height,
              child:
              ListView.builder(
                  padding: EdgeInsets.all(5),
                  itemCount: studentCourseAttendance.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 400,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ])),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Cource Name :",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(
                                        studentCourseAttendance[index]
                                            .coursename ??
                                            'null',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        "Student Absents :",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(
                                        studentCourseAttendance[index].absent ??
                                            'null',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        "Student Presents :",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(
                                        studentCourseAttendance[index]
                                            .present ??
                                            'null',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Spacer(),


                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        )
    );
  }
}
