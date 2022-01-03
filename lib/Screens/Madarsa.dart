import 'package:flutter/material.dart';
import 'package:theguiderclienttt/Data/Data.dart';
import 'package:theguiderclienttt/List/MAdarsaList/OnlineMadarsa.dart';
import 'package:theguiderclienttt/widget/Appbar_Custom.dart';

import '../globals.dart';

class OnlineMadarsa extends StatefulWidget {
  const OnlineMadarsa({Key key}) : super(key: key);

  @override
  _OnlineMadarsaState createState() => _OnlineMadarsaState();
}

class _OnlineMadarsaState extends State<OnlineMadarsa> {
  @override
  void initState() {
    Regestercource.clear();
    Allteachers_Uid.clear();
    Allteachers_Cource_Detail.clear();
    Retrive_all_teachers_Classes();
Data.Retrieve_MyCourtses();
   // DataR.Retrive_all_teachers_Classes();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
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
                      )),
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
                              InkWell(
                                  onTap: () {
                                   Navigator.pop(context);
                                  },
                                  child:Icon(
                                    Icons.arrow_back_ios_sharp,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 25,
                              ),
                              //   Text('Teacher Portal',style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w300),)
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text('Online Madarsa',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w300),),
            ),
           Expanded(
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    //childAspectRatio: (itemWidth / itemHeight),
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1),
                itemCount: madarsaList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                            madarsaList[index].navigation));
                      },
                      child: Container(

                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(madarsaList[index].image),
                            fit: BoxFit.cover,
                          ),
                          //color: const Color(0xff7c94b6),
                          border: Border.all(
                            color: Colors.deepPurple,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                              Colors.deepPurpleAccent.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(
                                  1, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(madarsaList[index].destination),
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
      ),
    );

  }
}
