import 'package:flutter/material.dart';
import 'package:theguiderclienttt/List/MAdarsaList/MyCourceList.dart';
import 'package:theguiderclienttt/Screens/Teacher_Cource_Detail.dart';
import 'package:theguiderclienttt/globals.dart';

class RegesterCourceList extends StatefulWidget {
 // const courceList({Key key}) : super(key: key);

  @override
  _RegesterCourceListState createState() => _RegesterCourceListState();
}

class _RegesterCourceListState extends State<RegesterCourceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text( "Cources List"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.2,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: EdgeInsets.all(5),
              itemCount: Allteachers_Uid.length,
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
                          Text(Allteachers_Uid.elementAt([index].first)),
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
