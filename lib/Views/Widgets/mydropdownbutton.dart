import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tema8/Consts/availablelanguages.dart';
import 'package:tema8/Consts/consts.dart';
import 'package:tema8/Models/appdata.dart';

//Widget used in mainpage.dart to show the dropdownbuttons

class MyDropDownButton extends StatelessWidget {
  const MyDropDownButton(this._fromOrTo, {Key? key}): super(key:key);

  final enumFromOrTo _fromOrTo;

  @override
  Widget build(BuildContext context){
    return _dropDownButton(context);
  }

  Widget _dropDownButton(BuildContext context){
    var provider = Provider.of<AppData>(context);

    return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: _fromOrTo == enumFromOrTo.TO ? Text(provider.toLang.name) : Text(provider.fromLang.name),

              items: listOfLanguages.values.map((String value){
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),

              onChanged: (newValue){
                if(newValue != null){
                  var lang = provider.getLanguagesFromString(newValue.toString());
                  if(_fromOrTo == enumFromOrTo.TO){
                    provider.setLanguage(_fromOrTo, lang);
                    }else {
                    provider.setLanguage(_fromOrTo, lang);
                  }
                }
              },
            ),
          ),
        )
    );
  }
}