import 'package:flutter/material.dart';
import 'package:theguiderclienttt/Config.dart';
import 'package:theguiderclienttt/List/homelist.dart';
import 'package:theguiderclienttt/globals.dart';

class HomeScreen extends StatefulWidget {
  //const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(right: 18,left: 18),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/istambol.png'),
                          fit: BoxFit.fill)),
                ),

                Container(
                  height: MediaQuery.of(context).size.height/1.49 ,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        //childAspectRatio: (itemWidth / itemHeight),
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12),
                    itemCount: homelist.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: () {

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  homelist[index].navigation));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(homelist[index].image),
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
                              Text(homelist[index].destination),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
