import 'package:flutter/material.dart';

class Toast extends StatelessWidget {
  //const Toast({Key? key}) : super(key: key);
  var Msg;
  Toast(this.Msg);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: showToast(Msg),
    );
  }

  showToast(var messege) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(messege ?? 'I dont Understand whats going on'),
        ],
      ),
    );
  }
}
