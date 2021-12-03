import 'package:flutter/material.dart';

class TranslatedResult extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return _translatedResult(context);
  }

  Widget _translatedResult(BuildContext context){
    //final provider = Provider.of<AppData>(context);

    return Card(
      color: Colors.blue[500],
      child: Container(
        height: (1/5 * MediaQuery.of(context).size.height),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                ]
              )
            )
          ]
        )
      ),
    );




  }
}