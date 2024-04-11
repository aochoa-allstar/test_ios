import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogAction extends StatelessWidget {
  final String title;
  final String msg;
  final Function exitFunc;
  final Function continueFunc;

  DialogAction({
    super.key,
    this.title = 'Alert',
    required this.msg,
    required this.exitFunc,
    required this.continueFunc,
  });
  late double h, w;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text(title.toString()),
      content: Container(
        width: w * 0.5,
        height: h * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(msg),
      ),
      actions: [
        _btnExit(),
        _btnContinue(),
      ],
    );
  }

  _btnExit() {
    return Container(
      width: w * 0.3,
      height: h * 0.06,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: TextButton(
          onPressed: () {
            Get.back();
            exitFunc();
            //function to clean de pad bat still in the pad
            // setState(() {
            //   keyPad?.currentState?.clear();
            //   signaturePic = '';
            // });
          },
          child: Text(
            'Exit',
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  _btnContinue() {
    return Container(
      width: w * 0.3,
      height: h * 0.06,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: TextButton(
          onPressed: () {
            continueFunc();
            //function to clean de pad bat still in the pad
            // setState(() {
            //   keyPad?.currentState?.clear();
            //   signaturePic = '';
            // });
          },
          child: Text(
            'New Signature',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
