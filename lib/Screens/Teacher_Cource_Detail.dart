import 'package:flutter/material.dart';
import 'package:theguiderclienttt/List/MAdarsaList/MyCourceList.dart';
import 'package:theguiderclienttt/globals.dart';

class Detail_of_CourcesList extends StatefulWidget {
  // const courceList({Key key}) : super(key: key);

  @override
  _Detail_of_CourcesListState createState() => _Detail_of_CourcesListState();
}

class _Detail_of_CourcesListState extends State<Detail_of_CourcesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("Detail of Cources "),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.2,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: EdgeInsets.all(5),
              itemCount: Allteachers_Declared_variables.length,
              itemBuilder: (BuildContext ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) =>));
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
                      // String STD_Db_CourceName;
                      // String STD_Db_StartHour;
                      // String STD_Db_Minutes;
                      //     String STD_Db_RoomId;
                      //     String STD_Db_StudentStrength;
                      //     String STD_Db_TeacherUid;
                      //     String STD_Db_CourceDuration;
                          //Text('data'),
                          Text(STD_Db_CourceName[index],style: TextStyle(color: Colors.black45),),
                          Text(STD_Db_StartHour[index]),
                          Text(STD_Db_Minutes[index]),
                          Text(STD_Db_RoomId[index]),
                          Text(STD_Db_StudentStrength[index]),
                          Text(STD_Db_TeacherUid[index]),
                          Text(STD_Db_CourceDuration[index]),
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
