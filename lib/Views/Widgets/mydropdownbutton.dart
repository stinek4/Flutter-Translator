import 'package:flutter/material.dart';

class MyDropDownButton extends StatelessWidget {
  // const MyDropDownButton(this._fromOrTo);

  // final keyFromOrTo _fromOrTo;
  var dropDownList = ['One','Two','Three'];

  @override
  Widget build(BuildContext context){
    return _dropDownButton(context);
  }

  Widget _dropDownButton(BuildContext context){

    return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              style: TextStyle(color: Colors.grey),
              items:
                dropDownList.map((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            ),
          ),
        )
    );
  }

}