import 'package:flutter/material.dart';
import 'package:theguiderclienttt/List/MAdarsaList/MyCourceList.dart';

class courceList extends StatefulWidget {
  const courceList({Key key}) : super(key: key);

  @override
  _courceListState createState() => _courceListState();
}

class _courceListState extends State<courceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text("My Cources List"),
          ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.2,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: EdgeInsets.all(5),
              // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //     maxCrossAxisExtent: 200,
              //     //childAspectRatio: (itemWidth / itemHeight),
              //     crossAxisSpacing: 1,
              //     mainAxisSpacing: 1),
              itemCount: CourceList.length,
              itemBuilder: (BuildContext ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CourceList[index].navigation));
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(CourceList[index].image),
                          fit: BoxFit.fill,
                        ),
                        //color: const Color(0xff7c94b6),
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(CourceList[index].destination),
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
