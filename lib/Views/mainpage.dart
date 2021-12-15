import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tema8/Consts/consts.dart';
import 'package:tema8/Models/appdata.dart';
import 'package:tema8/Views/Widgets/mydropdownbutton.dart';
import 'package:tema8/Views/Widgets/inputfield.dart';
import 'package:tema8/Views/Widgets/translatedcard.dart';
import 'package:tema8/Views/Widgets/translatedresult.dart';
import 'package:tema8/Views/Widgets/favoritesorhistory.dart';

//Only page in entire app, consists of Widgets in Widgetfolder. ie. InputField()

class MainPage extends StatefulWidget{
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{

  @override
  Widget build(BuildContext context){
    var provider = Provider.of<AppData>(context);

    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyDropDownButton(enumFromOrTo.FROM),
                IconButton(icon: const Icon(Icons.swap_horiz), onPressed: () {
                  Provider.of<AppData>(context, listen: false).switchLanguages();
                }),
                MyDropDownButton(enumFromOrTo.TO),
              ],
            ),
            Divider(),
            InputField(),
            Divider(),

      //If check, show translated result via TranslatedCard
            if(Provider.of<AppData>(context).currentTranslationModel != null) ... [
              TranslatedCard(),
              Divider(),
            ],

      // If there is history or favorites, showcase SwitchListTile
            if(provider.favorites.length > 0 || provider.history.length >0) ... [
              if(provider.favorites.isNotEmpty && provider.history.isNotEmpty) ... [
              FavoritesOrHistory(provider),
              ],
              TranslatedResult(provider.shouldShowHistory),
            ]
          ],
        )
      )
    );
  }

  AppBar _appBar(){
    return AppBar(
      title: Text("Google Translator"),
      elevation: 0.0,
    );
  }
}
