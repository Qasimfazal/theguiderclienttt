import 'package:flutter/material.dart';
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
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            GradientAppBar("Online Madarsa"),
           Expanded(
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
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
                          borderRadius: BorderRadius.circular(4),
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
