import 'package:flutter/material.dart';
import 'package:theguiderclienttt/Config.dart';
import 'package:theguiderclienttt/List/homelist.dart';
import 'package:theguiderclienttt/globals.dart';
import 'package:theguiderclienttt/widget/Appbar_Custom.dart';

class HomeScreen extends StatefulWidget {
  //const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true;
  void initState() {

    RetrieveData();
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(

        child: _loading ? Center(child: Container(
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
            child: CircularProgressIndicator())) :

        Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                GradientAppBar("Welcome to Guider"),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/istambol.png'),
                          fit: BoxFit.fill)),
                ),

                Expanded(

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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(   homelist[index].image,),
                                fit: BoxFit.cover,
                              ),
                              //color: const Color(0xff7c94b6),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.45),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset:
                                  Offset(1, 1), // changes position of shadow
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

