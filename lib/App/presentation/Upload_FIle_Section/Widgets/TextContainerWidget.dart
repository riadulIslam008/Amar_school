import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextContainerWidget extends StatelessWidget {
  final String fileName;
  final String buttonText;
  final VoidCallback onClick;

  const TextContainerWidget(
      {Key key, this.onClick, this.buttonText, this.fileName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = Get.width;

    return Row(
      children: [
         Container(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
            width: _width * 0.65,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Text(
              fileName,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
        
        SizedBox(width: 5),
        Expanded(
          child: MaterialButton(
            color: Colors.grey,
            onPressed: onClick,
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
