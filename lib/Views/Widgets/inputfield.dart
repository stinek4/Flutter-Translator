import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tema8/Models/appdata.dart';

//Widget used in mainpage.dart to show input field

class InputField extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return _inputField(context);
  }

  Widget _inputField(BuildContext context){
    var provider = Provider.of<AppData>(context, listen: false);

    return Card(
      elevation: 0.5,
      child: TextField(
        maxLines: 4,
        controller: provider.textFieldController,
        textInputAction: TextInputAction.done,
        onChanged: (newVal){
          provider.delayedTranslation(newVal);
        },
        onSubmitted: (newVal){
          provider.historyAddCheck();
        },
        autocorrect: false,
      )
    );
  }
}
